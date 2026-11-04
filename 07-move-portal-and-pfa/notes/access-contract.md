# Build the reads and writes the Portal and PFA need

[Back to steps](../steps.md)

- **What:** the CDXP-owned procedures and views (or API) that the Portal and PFA call, per [the access decision](../../02-decide-and-design/notes/access-pattern.md).
- **Reads:** the member grid, gap details, KPIs, provider status, documents, and admin configuration.
- **Writes:** PFA feedback, "not seen here", document uploads, and admin changes.
- **Access mapping:** rebuild who sees what from SSO attributes. This is what `alert.BuildMapping` does today.
  - The gap side is [`cdxp.BulkGapAccess`](../../02-decide-and-design/bulk-tables/10-BulkGapAccess.sql), rebuilt after each load.
  - The user side stays in the Portal (`UserPermission`, rebuilt at each SSO login). `cdxp` can't read the Portal database, so each call passes the user's access values, or all access for users in a `CanAccessAllAlerts` group.
- **Contract rules:** version it, make additive changes only, and run contract tests in both teams' pipelines.
