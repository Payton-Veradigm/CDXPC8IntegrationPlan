# Decide recovery targets and per-customer restore and deletion

[Back to steps](../steps.md)

- **Today:** a customer's TRX database can be restored, exported, or dropped on its own. TRX also has a DR node in Central US.
- **With shared tables:**
  - Point-in-time restore covers the whole database. Restoring one customer means restoring a copy and copying that customer's rows back.
  - Deleting a customer means batched deletes across every table, plus removing their Snowflake copies and document blobs.
- **Decide:**
  - Recovery point and recovery time targets for both products.
  - `cdxp`'s geo-DR setup.
- **Then:** build and rehearse the restore, export, and delete tooling before the first real customer moves.
