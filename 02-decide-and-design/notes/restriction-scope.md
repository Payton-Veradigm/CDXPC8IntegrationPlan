# Decide which restrictions apply to which tenants and gaps

[Back to steps](../steps.md)

- **The question:** does every restriction apply to every gap? Or does it depend on the tenant, the gap's source, and the audience (the PFA or the point of care)?
- **Today:**
  - Collaborate's filters are set per customer, and apply to ANR and OTB data.
  - CDXP's model checks apply to every payer's gaps, including Collaborate's published gaps. The restrictive code list is global.
- **Options:**
  - A. Keep both as they are: Collaborate's filters per customer, and CDXP's model checks on everything headed to the point of care.
  - B. Make CDXP's model checks configurable per tenant, alongside Collaborate's filters.
  - C. One combined rule set per tenant.
- **Lean:** A, so the side-by-side check against TRX can pass. Revisit B or C after the Portal and PFA move.
- **Open:** should the PFA show gaps that CDXP's model checks block from the point of care?
