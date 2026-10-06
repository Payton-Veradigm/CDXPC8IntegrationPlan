# Decide how gap types and lines of business map

[Back to steps](../steps.md)

- **Gap types:**
  - CDXP has 7: CI, CV, GIC, PatientSafety, MedicineAdherence, SDOH, and EDU.
  - Collaborate's intake accepts 6 of them, and rejects the whole request if it sees any other.
  - MedicineAdherence has no Collaborate match, and Collaborate's RX type has no CDXP match.
  - Collaborate classifies gaps by detail types, configured per customer.
- **Feedback:** CDXP allows feedback by gap type, while Collaborate configures it per customer.
- **LOB:** a `VARCHAR(10)` code in TRX, and a numeric key in CDXP.
- **Lean:** one crosswalk that both teams own, kept in CIEP's spec registry (#170062) or in a shared table.
