# Keep CDXP's model checks when FHIR Publish goes away

[Back to steps](../steps.md)

- **Why:** today CDXP checks Collaborate's gaps (FHIR validation, the model check, and restrictive codes) when FHIR Publish sends them back. Without FHIR Publish, those checks disappear.
- Move the checks to wherever [the restriction decision](../../02-decide-and-design/notes/restriction-order.md) puts them.
- Keep model-deactivation expiry working for gaps in the shared tables.
- **Compare:** for each customer both products serve, the gaps CDXP serves before and after the change must match.
