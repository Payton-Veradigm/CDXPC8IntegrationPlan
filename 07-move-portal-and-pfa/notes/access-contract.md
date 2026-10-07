# Build the reads and writes the Portal and PFA need

[Back to steps](../steps.md)

- **What:** the CDXP-owned procedures and views (or API) that the Portal and PFA call, per [the access decision](../../02-decide-and-design/notes/access-pattern.md).
- **Reads:** the member grid, gap details, KPIs, provider status, documents, and admin configuration.
- **Writes:** PFA feedback, "not seen here", document uploads, and admin changes.
- **Access mapping:** rebuild who sees what from SSO attributes. This is what `alert.BuildMapping` does today.
- **Contract rules:** version it, make additive changes only, and run contract tests in both teams' pipelines.
