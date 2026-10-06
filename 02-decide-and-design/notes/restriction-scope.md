# Decide which restrictions apply to which tenants and gaps

[Back to steps](../steps.md)

- **The question:** in the merged tables, does every restriction apply to every gap? Or does it depend on the tenant, the gap's source, and the audience (the PFA or the point of care)?
- **Today:**
  - Collaborate's filters are set per customer, and apply to ANR and OTB data.
  - CDXP's model checks apply to every payer's gaps, including Collaborate's published gaps. Its restrictive code list is global.
- **Options:**
  - A. Keep both as they are. Collaborate filters per customer; CDXP's model checks apply to everything headed to the point of care.
  - B. Make CDXP's model checks configurable per tenant, alongside Collaborate's filters.
  - C. One combined rule set per tenant, covering both.
- **Lean:** A for the merge. Revisit B or C when [converging filtering](../../10-converge-filtering/steps.md).
- **Open:** should the PFA show gaps that CDXP's model checks block from the point of care?
