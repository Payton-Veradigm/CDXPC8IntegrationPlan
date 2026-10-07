# Apply CDXP's model checks as decided

[Back to steps](../steps.md)

- **The checks:**
  - FHIR validation.
  - The model check (`cdxp.GapModels`).
  - Restrictive codes (`cdxp.RestrictiveModels`).
  - Model-deactivation expiry.
- **Today:** Collaborate's gaps only meet these checks when FHIR Publish sends them back to CDXP.
- **In CDXP's process:** apply them to Collaborate's data the way [the restriction decision](../../02-decide-and-design/notes/restriction-order.md) says. For example, a blocked gap might be hidden from the point of care but kept for the PFA.
- **Parity:** the side-by-side check has to show the same result as today, for both the PFA and the point of care.
