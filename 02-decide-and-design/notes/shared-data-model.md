# Agree the shared data model

[Back to steps](../steps.md)

- **What:** four shared tables in `cdxp`, each keyed by tenant first.
- **Who builds it:** CDXP, into the consolidated bulk tables, in its own codebase. Both teams design it, and Collaborate reviews it.
- **Full draft:** [shared-data-model-sql.md](shared-data-model-sql.md) (pseudo-SQL, plus the questions about simplifying it).
- **CDXP base:** Payer Automation's PA-4 already creates the generic `cdxp.Bulk*` tables; the shared model extends them. See [payer-automation-bulk-tables.md](payer-automation-bulk-tables.md).
- **C8 source:** design against `feature/pfa-refactor`, not Prod. What it changes: [pfa-refactor-data-model.md](pfa-refactor-data-model.md).
- **Coverage matrix:** [coverage-matrix.xlsx](coverage-matrix.xlsx) maps every column to the use cases that key, filter, read, or write it, and flags columns to drop, move to JSON, promote, or add.
- **Built from:** Collaborate's `alert` tables, including the columns from [the master-record removal](../../01-prerequisites/notes/master-record-removal.md) (branch `jk/pfa-refactor`), and CDXP's per-payer tables.
- **The tables:**
  - **`BulkPayerMember`:** one row per member, per tenant and LOB. It holds PHI, CDXP's match hashes, the PCP, and a JSON column for payer-specific attributes.
  - **`BulkPayerProvider`:** the payer's provider records (PCPs and attributed providers), keyed by the payer's provider ID, with the NPI.
  - **`BulkPayerGap`:** one row per gap. It has a shared core (identity, JSON content, blob link), Collaborate's lifecycle and feedback columns, and CDXP's delivery status.
  - **`BulkPayerProviderGap`:** which providers see a gap, and why.
- **The questions that would simplify it most:**
  - Do we need the provider-to-gap link at all? Every source we checked has at most one provider per gap.
  - Can every feed map to Collaborate's detail types? CDXP's feeds have none, which breaks the one-live-gap rule for them.
  - Does LOB live on the member, as in TRX, or on the gap, as in CDXP?
- **Feeds these decisions:** gap identity, member identity, lifecycle, FHIR Publish's replacement, gap types and LOB, column ownership, and PHI.
- **Must support parity:** the model needs every field that the side-by-side check compares with TRX.
- **Decided:** evidence (notes, claims, medications, procedures, diagnostics) gets no `Bulk*` tables. It lives in blob storage only (2026-11-02, Payton Obrycki).
