# Fix the clock, lock, and collation differences

[Back to steps](../steps.md)

- **Clock:** about 410 `GETDATE()` calls assume the VM's local time, but Azure SQL returns UTC. Apply [the time zone decision](../../02-decide-and-design/notes/time-basis.md).
- **Locks:**
  - Five procedures lock on fixed names: `UpsertDetailQueue`, `UpsertMasterQueue`, `UpsertMemberQueue`, `UpsertProviderQueue`, and `PublishAlerts`.
  - In one database, every customer would wait on the same lock.
  - Fix: add the tenant to each lock name.
- **Collation:** TRX declares none, while `cdxp` uses `SQL_Latin1_General_CP1_CI_AS`. Check what the deployed TRX databases actually use.
