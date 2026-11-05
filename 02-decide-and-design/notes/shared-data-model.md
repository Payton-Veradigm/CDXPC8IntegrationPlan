# Agree the shared data model

[Back to steps](../steps.md)

- **What:** the shared tables in `cdxp`, each partitioned by tenant. They're linked under **The tables** below.
- **Who builds it:** CDXP, into the consolidated bulk tables, in its own codebase. Both teams design it, and Collaborate reviews it.
- **Earlier draft:** [shared-data-model-sql.md](shared-data-model-sql.md), the first four-table version, with the simplification questions (S1 to S17) that later notes refer to.
- **CDXP base:** Payer Automation's PA-4 already creates the generic `cdxp.Bulk*` tables; the shared model extends them. See [payer-automation-bulk-tables.md](payer-automation-bulk-tables.md).
- **C8 source:** design against `feature/pfa-refactor`, not Prod. What it changes: [pfa-refactor-data-model.md](pfa-refactor-data-model.md).
- **Coverage matrix:** [coverage-matrix.xlsx](coverage-matrix.xlsx) maps every column to the use cases that key, filter, read, or write it, and flags columns to drop, move to JSON, promote, or add.
- **Built from:** Collaborate's `alert` tables, including the columns from [the master-record removal](../../01-prerequisites/notes/master-record-removal.md) (branch `jk/pfa-refactor`), and CDXP's per-payer tables.
- **The tables:** pseudo-SQL in [bulk-tables/](../bulk-tables/), where each column says whether it came from CDXP, from C8, or is new.
  - **Members:**
    - [`cdxp.BulkMember`](../bulk-tables/01-BulkMember.sql): one row per payer member, with PHI, match hashes, PCP and visits, plan, and org hierarchy.
    - [`cdxp.BulkMemberProviderStatus`](../bulk-tables/08-BulkMemberProviderStatus.sql): Not Seen Here, a practice's claim that a member isn't its patient.
  - **Providers:**
    - [`cdxp.Provider`](../bulk-tables/02-Provider.sql): CDXP's provider table (one row per NPI), expanded with the payer's record of each provider.
    - [`cdxp.BulkProviderGap`](../bulk-tables/06-BulkProviderGap.sql): a provider's role on a gap (attributed, PCP, or reporting), with its `cdxp.ProviderGapRole` lookup.
  - **Gaps:**
    - [`cdxp.BulkGap`](../bulk-tables/03-BulkGap.sql): one row per gap: identity, classification, delivery status, and lifecycle.
    - [`cdxp.BulkGapDetail`](../bulk-tables/05-BulkGapDetail.sql): the gap's content, one row per gap.
    - [`cdxp.BulkGapClinicalCode`](../bulk-tables/09-BulkGapClinicalCode.sql): the gap's codes, one row per code. PA-4 already builds it.
    - [`cdxp.BulkGapFeedback`](../bulk-tables/07-BulkGapFeedback.sql): every response to a gap, from the PFA, EHRs, and payers.
    - [`cdxp.BulkGapAuditLog`](../bulk-tables/04-BulkGapAuditLog.sql): each change to a gap's status or lifecycle.
    - [`cdxp.BulkGapAccess`](../bulk-tables/10-BulkGapAccess.sql): the provider identifiers a gap is visible under, which decide what Provider SSO users see.
  - **Reference lookups**, keyed on a clinical code's system and value, and not partitioned:
    - [`cdxp.QualityMeasure`](../bulk-tables/11-QualityMeasure.sql): a quality measure's names, description, category, and call to action.
    - [`cdxp.DiagnosisCode`](../bulk-tables/12-DiagnosisCode.sql): an ICD-10 code's description.
  - **Partitioning:** [`psPartitionByPayerKey`](../bulk-tables/00-PayerPartition.sql), one partition per tenant. PA-4's version replaces it.
  - **Not drafted here:** PA-4's runs and files (`BulkTracker`, `BulkFileDetail`) and its member-site matching tables, in [payer-automation-bulk-tables.md](payer-automation-bulk-tables.md). Evidence has no tables (see **Decided**).
- **The questions that would simplify it most:**
  - Do we need the provider-to-gap link at all? Every source we checked has at most one provider per gap.
  - Can every feed map to Collaborate's detail types? CDXP's feeds have none, which breaks the one-live-gap rule for them.
  - Does LOB live on the member, as in TRX, or on the gap, as in CDXP?
- **Feeds these decisions:** gap identity, member identity, lifecycle, FHIR Publish's replacement, gap types and LOB, column ownership, and PHI.
- **Must support parity:** the model needs every field that the side-by-side check compares with TRX.
- **Decided:** evidence (notes, claims, medications, procedures, diagnostics) gets no `Bulk*` tables. It lives in blob storage only (2026-11-02, Payton Obrycki).
