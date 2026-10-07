# Agree the shared data model

[Back to steps](../steps.md)

- **What:** four shared tables in `cdxp`, each keyed by tenant first.
- **Who builds it:** CDXP, into the consolidated bulk tables, in its own codebase. Both teams design it, and Collaborate reviews it.
- **Full draft:** [shared-data-model-sql.md](shared-data-model-sql.md) (pseudo-SQL, plus the questions about simplifying it).
- **Built from:** Collaborate's `alert` tables, including the gap-centric columns on branch `jk/pfa-refactor`, and CDXP's per-payer tables.
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
