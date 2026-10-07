# Decide how each restriction runs in CDXP's process

[Back to steps](../steps.md)

- **Today:**
  - **CDXP-only payers:** CDXP validates the gaps and checks their models at ingest.
  - **OTB:** CDXP validates the payer's file, Collaborate filters at staging, and CDXP checks again when FHIR Publish sends the gaps back.
  - **ANR:** Collaborate filters at staging, and CDXP checks when FHIR Publish sends the gaps back.
- **In CDXP's process:** Collaborate's filters and CDXP's checks run in one place. Decide their order, and what each one does to a gap.
- **Options for CDXP's model checks on Collaborate's data:**
  - A. Drop the gap at ingest. It's then blocked everywhere, including the PFA.
  - B. Keep the gap, but hide it from the point of care. The PFA keeps today's behavior.
- **Lean:** B, because it matches what TRX and the PFA show today, so parity holds.
