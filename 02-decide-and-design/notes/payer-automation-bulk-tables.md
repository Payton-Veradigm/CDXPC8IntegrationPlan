# Payer Automation's bulk tables, and what the shared model adds

[Back to steps](../steps.md)

- **What:** Brian Fontana's Payer Automation stack in `Ciep.AppService`, under Epic [170061](https://dev.azure.com/veradigm/CIEP/_workitems/edit/170061) (checked 2026-11-04). Each PR builds on the one before:
  - [PA-1 53424](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53424): `cdxp.PayerFeedMap` (+ Field, RowRule, ValueMap) maps a payer's columns to spec fields. Merged.
  - [PA-2 53428](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53428): standardize payer data into canonical rows, and set aside gaps with structural issues. Merged.
  - [PA-3 53447](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53447): the spec-driven FHIR bundle builder. Merged.
  - [PA-4 53455](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53455): nine generic `cdxp.Bulk*` tables and `psPartitionByPayerKey` (work item 170078). Merged.
  - [PA-5 53480](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53480): `cdxp.spSaveBulkGapBatch`, a set-based save, and `spUpdateBulkStatistics` (work item 170079). Merged 2026-11-04.
  - Open: [PA-6 53494](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53494) typed value transforms, [PA-7 53507](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53507) Payer Parser reads a flat file into gaps, [PA-8 53525](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53525) wires the parser to the Gap Adapter and the save.
  - Still to build: PA-9 the Payer Parser app (in progress), PA-16 the status funnel, PA-17 the gap readers, PA-18 expiry and matching, PA-19 reporting and HNA sync, PA-23 C8 publish intake, MIG-5 the history copy, MIG-6 the parallel run and cutover.
- **PA-4's rule:** each table is the union of the migrating payers' columns (eighteen bulk payers, Humana included), so history copies without losing a column. Nothing reads or writes the tables until PA-8.

## What PA-4 already builds

- **Partitioning:** `pfPartitionByPayerKey` (SMALLINT, RANGE RIGHT, 1 to 200) and `psPartitionByPayerKey`. Every table is clustered on (`PayerPartitionKey`, identity). This replaces our `00-PayerPartition.sql`.
- **BulkGap:** `GapKey`, `PayerPartitionKey`, `GapStatusKey`, `GapTypeKey`, `LineOfBusinessKey`, `MemberKey`, `FileDetailKey`, `TrackerKey`, `FileLocation` (NOT NULL), `PayerGapId` (NOT NULL, unique per payer), `HealthPlanKey`, `CorrelationID`, `ProviderNPIKey`, `NPI`, `PayerProviderNPIRegistrationKey`, `IsCoreNpi`, `RunId`, audit.
- **BulkMember:** the per-payer member tables' columns plus `AltMemberID`, `ProviderNPIKey` + `SitePartitionKey` (-> `cdxp.SiteProvider`), and `HealthPlanKey`.
- **BulkGapAuditLog:** `GapStatusKey`, `Source`, `IsDuplicate`, as in the per-payer audit logs.
- **BulkGapClinicalCode:** one row per code (type, system, version, extension, value, model), unique per gap.
- **BulkMemberSite, BulkMemberMatchScore, BulkMemberDelta:** member-to-site matching and PayerPath deltas.
- **BulkTracker:** one row per run. It also takes `C8PublishDetail`'s columns (`C8PublishID`, `SuccessSignOff`), so a C8 publish is a tracker row.
- **BulkFileDetail:** one row per file, with `PayerFeedMapKey`, `SpecKey`, and the parser's counts.
- **Save (PA-5):** takes a JSON array of gaps, each with a `Member` and `Codes`. It writes BulkMember, BulkGap, BulkGapClinicalCode, BulkGapAuditLog, and BulkMemberSite.
  - A status only moves up, except Expired reopening to New.
  - A gap with no `PayerGapId`, member ID, first name, or valid DOB is skipped.

## Runs: `BulkTracker`

- **Brian's run is a tracker row.** `BulkTracker` replaces the per-payer trackers and `cdxp.C8PublishDetail` (PA-4).
  - Files hang off a run (`BulkFileDetail.TrackerKey`), and the parser takes the run from the file (PA-8).
  - The save needs a tracker that belongs to the payer, or it saves nothing (PA-5).
  - Payer Parser runs one run per payer at a time (PA-9).
- **C8 publishes become tracker rows** (PA-23): the publish ID and sign-off move onto `BulkTracker`, and the files are parsed only once the publish is signed off.
- **Expiry follows the run** (PA-18): a per-payer mode, run-wide or tracker-scoped, and only a Parsed file counts as complete.
  - Today's procedures are payer-wide either way: some payers expire open gaps the latest tracker didn't carry, and the C8 family expires open gaps not on the latest publish.
- **For now, RAA's imports keep C8's staging runs.** They come into CDXP the way they came into TRX for a while, so members and gaps keep `FirstStagingRunId` and `LastStagingRunId` (decided 2026-11-05, Payton Obrycki).
- **What a C8 staging run does that a tracker doesn't**, for when RAA's data comes straight into CDXP's process:
  - Scope: a staging run is one LOB and alert type, and only that scope goes out of source. A tracker has neither, so a quality-only run would expire risk gaps.
  - A CTQ hold on staged data: sign-off holds files before they're parsed. That suits C8's publishes, which CTQ already approved, but leaves nothing in SQL for CTQ to review.
  - The data month that member-month snapshots key on, and a link from C8's `StagingRunId` to tracker rows for migrated history.

## What the shared model adds on top

Our drafts are in [../bulk-tables/](../bulk-tables/). The C8 side should follow [pfa-refactor-data-model.md](pfa-refactor-data-model.md).

- **Columns to add to PA-4's tables:**
  - BulkGap: C8 identity (`DetailId`, `DetailTypeId`, `DetailCode`, `InternalGapId`), lifecycle (`IsInSource`, `IsExpired`, `ExpiredDate`, `ClosedDate`, `LatestActivationDate`), period (`EvaluationPeriod`, `ProgramYear`), and `GapSource`.
  - BulkMember: all of `alert.Member`'s C8 columns (PCP, plan, org hierarchy, risk contracts, visits, deceased).
  - BulkGapAuditLog: lifecycle changes alongside status changes.
- **Tables PA doesn't have:**
  - `PayerProvider` (the payer's record of a `cdxp.Provider`) and `BulkProviderGap` (a provider's role on a gap).
  - `BulkGapDetail` (gap content) and `BulkGapFeedback`. Evidence has no tables; it lives in blob storage only.
  - `BulkMemberProviderStatus` (Not Seen Here, from C8's `MemberProviderStatus`).
  - `BulkGapAccess` (which provider identifiers each gap is visible under, from C8's `alert.Mapping`).
  - Reference lookups for the clinical codes: `QualityMeasure` (a measure's names, description, category and call to action) and `DiagnosisCode` (an ICD-10 code's description).
  - Not modeled yet: documents and member months.
- **The save:** `spSaveBulkGapBatch`'s JSON contract and checks have to grow to carry detail, providers, and the C8 columns. Otherwise PA-8 can't fill the new tables.

## Conflicts to settle with Brian

- **NPI and provider keys on the gap and member.**
  - PA-4 puts `NPI`, `ProviderNPIKey`, `PayerProviderNPIRegistrationKey`, and `IsCoreNpi` on BulkGap, and `ProviderNPIKey` on BulkMember.
  - We decided the gap's providers go through `BulkProviderGap`, and that NPI lives on `cdxp.Provider` only.
  - PA's keys point at CDXP's site-level registration (`SiteProvider`, `PayerProviderNPIRegistration`), which is a different thing from the payer's provider record.
- **`FileLocation` is NOT NULL.** That keeps the FHIR bundle in blob storage, which is now the only home for a gap's evidence, so the pointer stays.
  - It also blocks gaps that have no bundle, which includes C8 gaps until they come through PA.
  - The rest of the content goes in SQL: `BulkGapDetail` and the canonical rows from PA-2.
  - Blobs are deleted 90 days after their last write ([S14](shared-data-model-sql.md)). Evidence in blob only needs that changed for these bundles.
- **`PayerGapId` is NOT NULL and unique per payer.** C8 gaps can lack a partner gap ID (C8 falls back to `InternalGapId`). C8's own uniqueness rule is the live-gap identity: member, detail code, detail type, program year.
- **The status only moves up.** That fits CDXP's delivery status. C8's lifecycle (`IsInSource`, `IsExpired`) and its derived Open/Responded/Closed status need their own columns and rules, not `GapStatusKey`.
## What PA settles for us

- **S7 (one load table):** yes. `BulkTracker` (runs, including C8 publishes) and `BulkFileDetail` (files). C8's staging run IDs stay on members and gaps for now, while RAA's imports still run as staging runs (see Runs).
- **Partitioning and keys:** use PA-4's scheme and its (`PayerPartitionKey`, identity) clustering.
- **Clinical code table:** keep `BulkGapClinicalCode`, which answers our open question. Draft: [09-BulkGapClinicalCode.sql](../bulk-tables/09-BulkGapClinicalCode.sql).
  - `BulkGapDetail`'s code columns moved there: `ConditionCode`, `ModelName`, `ModelNo`, `DiagnosisCode`, and `MeasureNameModel`.
  - The descriptions moved to lookups keyed on the code: `ShortMeasureName`, `MeasureName`, `MeasureDescription`, `MeasureCategoryName` and `CallToAction` to `QualityMeasure`, and `DiagnosisDescription` to `DiagnosisCode`.
  - In `QualityMeasure`, the short name is a column of its own: it's the bulk format's measure code, but C8's measure code is `SourceMeasureId`, and C8's short name is a separate label.
  - C8 gaps need their codes in the save's `Codes` array: the HCC and model, the primary diagnosis, or the measure.
