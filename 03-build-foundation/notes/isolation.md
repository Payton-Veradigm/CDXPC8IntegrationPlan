# Build tenant isolation and prove it

[Back to steps](../steps.md)

- Row-level security keyed on the tenant, set for each session.
- Filters in Collaborate's app as a second layer (EF Core query filters), added with the per-customer switch in phase 6.
- **Tests that prove:**
  - A Collaborate session can't read another customer's rows.
  - CDXP's site-based reads across payers still work.
- **Depends on:** [the isolation decision](../../02-decide-and-design/notes/tenant-isolation.md) and compliance sign-off.
