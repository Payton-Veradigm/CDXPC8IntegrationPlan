# Build per-customer restore, export, and delete tooling

[Back to steps](../steps.md)

- **Restore:** bring back one customer's rows from a restored copy of the database.
- **Export:** hand one customer's data back, for example when a contract ends.
- **Delete:** remove one customer from every table, its Snowflake copies, and its document blobs, in batches.
- Rehearse all three before the first Collaborate payer is cut in.
- **Depends on:** [the recovery decision](recovery-and-deletion.md).
