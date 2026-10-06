# Agree the shared data model

[Back to steps](../steps.md)

- **What:** four shared tables in `cdxp`, each keyed by tenant first.
- **Full draft:** [shared-data-model-sql.md](shared-data-model-sql.md) (pseudo-SQL, plus the questions about simplifying it).
- **Built from:** Collaborate's `alert` tables after the master-record removal, and CDXP's per-payer tables.
- **The tables:**
  - **`BulkPayerMember`:** one row per member, per tenant and LOB. It holds PHI, CDXP's match hashes, the PCP, and a JSON column for payer-specific attributes.
  - **`BulkPayerProvider`:** the payer's provider records (PCPs and attributed providers), keyed by the payer's provider ID, with the NPI.
  - **`BulkPayerGap`:** one row per gap. It has a shared core (identity, JSON content, blob link), Collaborate's lifecycle and feedback columns, and CDXP's delivery status.
  - **`BulkPayerProviderGap`:** which providers see a gap, and why.
- **The questions that would simplify it most:**
  - Do we need the provider-to-gap link at all? Every source we checked has at most one provider per gap, and after the master-record removal, providers are reached through the member's PCP.
  - Can every feed map to Collaborate's detail types? CDXP's feeds have none, which breaks the one-live-gap rule for them.
  - Does LOB live on the member, as in TRX, or on the gap, as in CDXP?
- **Feeds these decisions:** gap identity, member identity, lifecycle, gap types and LOB, column ownership, and PHI.
