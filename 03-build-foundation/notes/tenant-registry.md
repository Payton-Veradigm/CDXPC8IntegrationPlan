# Add Collaborate customers to the tenant registry

[Back to steps](../steps.md)

- The consolidated tables already give each payer a partition.
- Add a tenant row and a partition for each Collaborate customer that isn't a CDXP payer.
- Key them by `GlobalPayerID`, which matches Collaborate's `VeradigmPayerId`.
- Use the crosswalk from the prerequisites.
- **Depends on:** [the tenant key decision](../../02-decide-and-design/notes/tenant-key.md).
