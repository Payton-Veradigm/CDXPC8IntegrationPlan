# Review the consolidated table design with Collaborate before it's built

[Back to steps](../steps.md)

- **Why:** design the consolidated tables once, for both products, so one database doesn't end up with two shared models.
- **Bring:** [the data model draft](../../02-decide-and-design/notes/shared-data-model.md).
- **Check for:**
  - Room for Collaborate customers as tenants.
  - Collaborate's gap identity and lifecycle columns.
  - Extension tables that each product owns.
- **CIEP's design already includes:**
  - One partition per payer.
  - Every table clustered on the partition key first.
  - Four coding rules:
    1. Scope every statement to one partition.
    2. Use `OPTION (RECOMPILE)` where payer sizes vary.
    3. Delete in batches.
    4. Make additive changes only.
