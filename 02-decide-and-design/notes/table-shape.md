# Decide the shape of the shared tables

[Back to steps](../steps.md)

- **Why:** two shared models in one database would recreate today's duplication.
- **Options:**
  - A. CIEP's `BulkPayer*` tables, generalized to customers. Collaborate adopts them and adds its own columns.
  - B. A shared core (member, gap identity, content, lifecycle) modeled on the TRX tables after the master-record removal, plus extension tables that each product owns. CIEP's `BulkPayer*` tables become this core.
  - C. Co-locate first. Move TRX's tables into `cdxp` nearly as they are, with a tenant key, next to `BulkPayer*`, and converge them later.
- **Trade-offs:**
  - A is the biggest rewrite for Collaborate.
  - B gives one row per gap and clear ownership, but needs agreement before CIEP builds.
  - C gets off the VMs fastest, but leaves two gap models until a second project converges them.
- **Lean:** B, with C as the fallback if we can't agree in time.
