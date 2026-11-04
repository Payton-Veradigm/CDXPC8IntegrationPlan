# Payer Automation's bulk tables, and what the shared model adds

[Back to steps](../steps.md)

- **What:** Brian Fontana's Payer Automation stack in `Ciep.AppService`, all active against `DevBranch` (checked 2026-10-30). Each PR builds on the one before:
  - [PA-1 53424](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53424): `cdxp.PayerFeedMap` (+ Field, RowRule, ValueMap) maps a payer's columns to spec fields.
  - [PA-2 53428](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53428): standardize payer data into canonical rows, and set aside gaps with structural issues.
  - [PA-3 53447](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53447): the spec-driven FHIR bundle builder.
  - [PA-4 53455](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53455): nine generic `cdxp.Bulk*` tables and `psPartitionByPayerKey` (work item 170078). Autocomplete is set.
  - [PA-5 53480](https://dev.azure.com/veradigm/CIEP/_git/Ciep.AppService/pullrequest/53480): `cdxp.spSaveBulkGapBatch`, a set-based save, and `spUpdateBulkStatistics` (work item 170079).
  - Coming: PA-7 Payer Parser, PA-8 wires it to the save, PA-19 HNA registration, MIG-5 copies the twelve migrating payers' history.
- **PA-4's rule:** each table is the union of the twelve migrating payers' columns, so history copies without losing a column. Nothing reads or writes the tables until PA-8.

## What PA-4 already builds

- **Partitioning:** `pfPartitionByPayerKey` (SMALLINT, RANGE RIGHT, 1 to 200) and `psPartitionByPayerKey`. Every table is clustered on (`PayerPartitionKey`, identity). This replaces our `00-PayerPartition.sql`.
- **BulkGap:** `GapKey`, `PayerPartitionKey`, `GapStatusKey`, `GapTypeKey`, `LineOfBusinessKey`, `MemberKey`, `FileDetailKey`, `TrackerKey`, `FileLocation` (NOT NULL), `PayerGapId` (NOT NULL, unique per payer), `HealthPlanKey`, `CorrelationID`, `ProviderNPIKey`, `NPI`, `PayerProviderNPIRegistrationKey`, `IsCoreNpi`, `RunId`, audit.
- **BulkMember:** HPPMember's columns plus `AltMemberID`, `ProviderNPIKey` + `SitePartitionKey` (-> `cdxp.SiteProvider`), and `HealthPlanKey`.
- **BulkGapAuditLog:** `GapStatusKey`, `Source`, `IsDuplicate`, as in HPP.
- **BulkGapClinicalCode:** one row per code (type, system, version, extension, value, model), unique per gap.
- **BulkMemberSite, BulkMemberMatchScore, BulkMemberDelta:** member-to-site matching and PayerPath deltas.
- **BulkTracker:** one row per run. It also takes `C8PublishDetail`'s columns (`C8PublishID`, `SuccessSignOff`), so a C8 publish is a tracker row.
- **BulkFileDetail:** one row per file, with `PayerFeedMapKey`, `SpecKey`, and the parser's counts.
- **Save (PA-5):** takes a JSON array of gaps, each with a `Member` and `Codes`. It writes BulkMember, BulkGap, BulkGapClinicalCode, BulkGapAuditLog, and BulkMemberSite.
  - A status only moves up, except Expired reopening to New.
  - A gap with no `PayerGapId`, member ID, first name, or valid DOB is skipped.

## What the shared model adds on top

Our drafts are in [../bulk-tables/](../bulk-tables/). The C8 side should follow [pfa-refactor-data-model.md](pfa-refactor-data-model.md).

- **Columns to add to PA-4's tables:**
  - BulkGap: C8 identity (`DetailId`, `DetailTypeId`, `DetailCode`, `InternalGapId`), lifecycle (`IsInSource`, `IsExpired`, `ExpiredDate`, `ClosedDate`, `LatestActivationDate`), period (`EvaluationPeriod`, `ProgramYear`), and `GapSource`.
  - BulkMember: all of `alert.Member`'s C8 columns (PCP, plan, org hierarchy, risk contracts, visits, deceased).
  - BulkGapAuditLog: lifecycle changes alongside status changes.
- **Tables PA doesn't have:**
  - `BulkProvider` and `BulkProviderGap` (the payer's providers and their role on a gap).
  - `BulkGapDetail` (gap content) and `BulkGapFeedback`. Evidence has no tables; it lives in blob storage only.
  - `BulkMemberProviderStatus` (Not Seen Here, from C8's `MemberProviderStatus`).
  - `BulkGapAccess` (which provider identifiers each gap is visible under, from C8's `alert.Mapping`).
  - Not modeled yet: documents and member months.
- **The save:** `spSaveBulkGapBatch`'s JSON contract and checks have to grow to carry detail, providers, and the C8 columns. Otherwise PA-8 can't fill the new tables.

## Conflicts to settle with Brian

- **NPI and provider keys on the gap and member.**
  - PA-4 puts `NPI`, `ProviderNPIKey`, `PayerProviderNPIRegistrationKey`, and `IsCoreNpi` on BulkGap, and `ProviderNPIKey` on BulkMember.
  - We decided the gap's providers go through `BulkProviderGap`, and that NPI lives on `BulkProvider` only.
  - PA's keys point at CDXP's site-level registration (`SiteProvider`, `PayerProviderNPIRegistration`), which is a different thing from the payer's provider record.
- **`FileLocation` is NOT NULL.** That keeps the FHIR bundle in blob storage, which is now the only home for a gap's evidence, so the pointer stays.
  - It also blocks gaps that have no bundle, which includes C8 gaps until they come through PA.
  - The rest of the content goes in SQL: `BulkGapDetail` and the canonical rows from PA-2.
  - Blobs are deleted 90 days after their last write ([S14](shared-data-model-sql.md)). Evidence in blob only needs that changed for these bundles.
- **`PayerGapId` is NOT NULL and unique per payer.** C8 gaps can lack a partner gap ID (C8 falls back to `InternalGapId`). C8's own uniqueness rule is the live-gap identity: member, detail code, detail type, program year.
- **The status only moves up.** That fits CDXP's delivery status. C8's lifecycle (`IsInSource`, `IsExpired`) and its derived Open/Responded/Closed status need their own columns and rules, not `GapStatusKey`.
## What PA settles for us

- **S7 (one load table):** yes. `BulkTracker` (runs, including C8 publishes) and `BulkFileDetail` (files). C8's staging run IDs should map to tracker rows rather than sit on every gap.
- **Partitioning and keys:** use PA-4's scheme and its (`PayerPartitionKey`, identity) clustering.
- **Clinical code table:** keep `BulkGapClinicalCode`, which answers our open question. Draft: [09-BulkGapClinicalCode.sql](../bulk-tables/09-BulkGapClinicalCode.sql).
  - `BulkGapDetail`'s code columns moved there: `ConditionCode`, `ModelName`, `ModelNo`, `DiagnosisCode`, and `MeasureNameModel`.
  - `ShortMeasureName` stays. It's HPP's measure code, but C8's measure code is `SourceMeasureId`, and C8's short name is a separate label.
  - C8 gaps need their codes in the save's `Codes` array: the HCC and model, the primary diagnosis, or the measure.
