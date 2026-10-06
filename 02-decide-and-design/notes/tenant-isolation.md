# Decide how customers' data is kept apart

[Back to steps](../steps.md)

- **Why:** each customer has its own TRX database today, for compliance and isolation. Shared tables need an equivalent.
- **The catch:** the products read differently.
  - Collaborate reads within one customer.
  - CDXP reads across payers by site, because a practice sees gaps from several payers.

  A filter that allows only one tenant would break CDXP.
- **Options:**
  - A. Row-level security on the tenant key for Collaborate's logins, plus filters in the app. CDXP's cross-tenant reads go only through its own procedures.
  - B. Option A, plus a separate encryption key per tenant for PHI.
  - C. A separate database per tenant on one shared schema. This rules out cross-tenant joins.
  - D. Shared tables by default, with separate databases for customers whose contracts require them.
- **Lean:** A, while keeping D possible. Compliance has to sign off before any table is built.
- **Today:** `cdxp` has no row-level security.
