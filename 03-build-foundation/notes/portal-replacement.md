# Copy the Portal data that CDXP's process needs

[Back to steps](../steps.md)

- Carry out [the Portal data decision](../../02-decide-and-design/notes/portal-dependencies.md), item by item.
- **Reference data and rules:** a sync job copies the Portal tables into `cdxp`. Collaborate has chosen copying over cross-database reads before, in its CDXP integration.
- **FHIR Publish rules:** skip them. They retire when the old paths turn off (phase 8).
- **Permission and roster data:** handle as agreed with Security.
