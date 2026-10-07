# Build the migration, reconciliation, and per-customer restore tooling

[Back to steps](../steps.md)

- **Migration:**
  - Extend CIEP's history migration routine (#170105) so it can read a TRX database.
  - Copy chart bytes from TRX to Blob Storage.
  - Convert timestamps per [the time zone decision](../../02-decide-and-design/notes/time-basis.md).
- **Reconciliation reports:** row counts and checksums per table, per tenant.
- **Cutover:** reuse CIEP's parallel run and cutover switch (#170106).
- **Per-customer tooling:** restore, export, and delete one customer, per [the recovery decision](recovery-and-deletion.md).
