# Implement the shared data model in the consolidated tables

[Back to steps](../steps.md)

- Start from the consolidated `BulkPayer*` tables, which the CDXP team builds in its own project.
- **Add what [the shared data model](../../02-decide-and-design/notes/shared-data-model.md) needs:**
  - The live-gap identity.
  - Lifecycle and feedback columns.
  - Extension tables that each product owns.
  - History tables.
- **Use new tables, not changes to old ones.** About 31 legacy `cdxp` tables were created with a setting that blocks filtered indexes, and the live-gap rule needs one.
- Follow CIEP's four rules:
  1. Scope every statement to one partition.
  2. Use `OPTION (RECOMPILE)` where tenant sizes vary.
  3. Delete in batches.
  4. Make additive changes only.
- **Collaborate's part:** review the tables against what the PFA needs.
