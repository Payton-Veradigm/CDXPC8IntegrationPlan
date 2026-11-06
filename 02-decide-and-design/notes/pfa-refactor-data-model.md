# C8 data model on feature/pfa-refactor

[Back to steps](../steps.md)

- **What:** the master-record removal, now on the shared branch `feature/pfa-refactor` in `veradigm-payer-portal` (Feature [170585](https://dev.azure.com/veradigm/Collabor8/_workitems/edit/170585)). Not scheduled for `main` or Prod yet.
- **Checked out at:** `C:\veradigm-payer-portal-pfa-refactor` (worktree). Tip `07d38e295`, 2026-10-28.
- **Guide:** [PFA Refactor: Changes from Main and Local Development Guide](https://veradigm.atlassian.net/wiki/spaces/TECH/pages/7430504497) (Confluence, v4).
- **Source rule (from Jason):** use the branch and the CKB together. The CKB documents Prod; when they disagree, the branch wins.
- **Compared against:** `C:\C8DB` TRX `release/2026.06.01`, the baseline the [bulk-table drafts](../bulk-tables/) were laid in from.

## The model change

- `alert.Detail` is the gap. It belongs to `alert.Member` by `AlertMemberId` and carries its own `ProviderId`.
- `alert.Master` and its tables (`MasterHistory`, `MasterQueue`, `MasterStaging`, `MasterState`, `AlertCompletedDate`...) move to the `archive` schema as read-only history.
- One live gap per member, detail code, detail type, and program year (`ux_alertDetail_LiveGapIdentity`, filtered on `IsInSource = 1 AND IsExpired = 0`).

## alert.Detail (the gap)

- **Added:**
  - `ProviderId VARCHAR(100)`: the provider the gap was sent under. NPI and group come from `alert.vw_GapProvider`.
  - `IsInSource BIT`, which replaces `isActive`.
  - `IsExpired BIT` and `ExpiredDate DATETIME2`: payer-configured expiry, separate from dropping out of source.
  - `EvaluationPeriod INT`, and `ProgramYear INT` (quality only).
  - `FeedbackUser NVARCHAR(256)`: who entered the PFA response.
  - `GapSource VARCHAR(50)`: where the gap originated.
- **Removed:** `isActive`, `AlertCompletedDateId`, `ExternalFeedbackSource`, `ExternalFeedbackSourceId`. `ExternalSourceId` stays.
- **Status:** not stored. `alert.vw_GapStatus` derives Open, Responded, or Closed:
  - Closed when `IsInSource = 0` or `IsExpired = 1`.
  - Responded when the member is deceased, the gap has PFA or external feedback, or the member is Not Seen Here for the gap's provider.

## alert.Member

- **Added:** `IsDeceased BIT` and `DeceasedDate DATE` (deceased moved off the master).

## alert.Provider

- No column changes.

## New tables

- **`alert.FeedbackHistory`:** prior PFA responses, one row per response. Columns: `DetailId`, `Feedback`, `FeedbackDate`, `FeedbackDiagnosisCode`, `FeedbackNpi`, `FeedbackSourceId`, `FeedbackUser`, created date and by. Feedback is saved per gap.
- **`alert.MemberProviderStatus`** (+ history): per member and provider answers, today Not Seen Here. Columns: `AlertMemberId`, `ProviderId`, `IsNotSeenHere`, `NotSeenHereDate`, created and modified.
- **`alert.MemberMonths`:** a monthly snapshot of the member's PCP and enrollment: `AlertMemberId`, `SnapshotMonth`, `StagingRunId`, `PCPId`, `PCPLastVisitDate`, `IsTermed`, `RunDate`.
- **`alert.GapType`:** `alert.AlertType` renamed in place (ids unchanged): `GapTypeId`, `GapTypeName`, `GapTypeDisplayName`.

## Documents

- `alert.Document` adds `AlertMemberId`, `GapTypeId`, `UploadProviderId`, and `UploadNpi`. A document belongs to the member's PCP at upload time, and that stamp doesn't move.
- `alert.DocumentDetail` (document-to-gap link) adds `ProviderId` and `Npi`: the gap's provider at tagging time.
- `alert.vw_DocumentProvider` decides which provider can see a document.

## Views added or moved

- **Added:** `vw_GapStatus`, `vw_GapProvider`, `vw_GapReportedAnswer`, `vw_MemberPcp`, `vw_MemberGapRollup`, `vw_MemberDetailTypeGapRollup`, `vw_VisibleDetailRecords`, `vw_DocumentProvider`, `vw_MemberMonthsLatest`, `vw_LobMemberSettings`, `vw_DetailTypeGroup`.
- **Moved to `archive`:** `vw_ActiveMasterRecords`, `vw_AllMasterRecords`, the `vw_Risk_Detail*` views.
- **Dropped:** the Master-based views (`vw_MappedMasterRecords`, `vw_InProgressAlerts`, ...) and `report.vw_ReportBuilderFeedbackCompleted`.

## What it means for the bulk-table drafts

- **BulkGap:**
  - Laid in `IsInSource` (replacing `IsActive`), `IsExpired`, `ExpiredDate`, `EvaluationPeriod`, `ProgramYear`, and `GapSource`.
  - `MasterId` can go, since Master is archived.
  - `AlertCompletedDateId` is already out.
- **BulkGapDetail (feedback):**
  - `FeedbackUser` is now a real C8 column.
  - The branch removes `ExternalFeedbackSourceId`. Which EHR answered is `ExternalSourceId` -> `alert.ExternalSource`.
  - `alert.FeedbackHistory` keeps each replaced response. The shared model keeps one response per gap, so keeping that history is open.
- **BulkProviderGap:**
  - The Attributed provider now comes from `alert.Detail.ProviderId`, not `alert.Master.ProviderId`. Exactly one per gap.
  - The PCP still comes from `alert.Member.PCPId`.
- **BulkMember:** laid in `IsDeceased` and `DeceasedDate`.
- **BulkGapAuditLog:** `IsActive` is now `IsInSource`, and `IsExpired` is added.
- **BulkMemberProviderStatus:** Not Seen Here, from `MemberProviderStatus`, which `vw_GapStatus` reads.
- **BulkGapAccess:** `alert.Mapping`, which the branch keys on the gap. Its keys come from the gap's Attributed provider, not the PCP.
- **Not modeled yet:**
  - The member monthly snapshot (`MemberMonths`).
  - Documents and their gap links.
- **Gap status:**
  - C8 derives Open, Responded, or Closed.
  - CDXP stores a delivery status (`GapStatusKey`).
  - Decide whether the shared model stores one, the other, or both.
- **Open (from the guide's tickets):**
  - 170875 aligns FeedbackTypes with VPI and removes the per-customer configuration. That bears on merging C8's and CDXP's feedback types.
  - 170894 is research on who-selected-feedback tracking.
