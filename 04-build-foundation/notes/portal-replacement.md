# Replace TRX's reads of the Portal database

[Back to steps](../steps.md)

- Carry out [the Portal decision](../../02-decide-and-design/notes/portal-dependencies.md), object by object.
- **Reference data:** a sync job copies the Portal tables into `cdxp`. Collaborate already chose copying over cross-database reads once, in its CDXP integration.
- **FHIR Publish objects:** skip them. They retire in phase 7.
- **Permission and roster data:** as agreed with Security.
