# Decide where each restriction runs in the merged flow

[Back to steps](../steps.md)

- **Today:**
  - **CDXP-only payers:** CDXP validates the gaps and checks their models at ingest.
  - **OTB:** CDXP validates the payer's file, Collaborate filters at staging, and CDXP checks again when FHIR Publish sends the gaps back.
  - **ANR:** Collaborate filters at staging, and CDXP checks when FHIR Publish sends the gaps back.
- **What changes:** once FHIR Publish is gone, Collaborate's gaps no longer pass CDXP's checks on the way back.
- **Options:**
  - A. Run CDXP's model checks during Collaborate's staging. A restricted gap is then blocked everywhere, including the PFA.
  - B. Run them when CDXP reads visible gaps for the point of care. The PFA keeps today's behavior.
- **Lean:** B for the merge, because it keeps what each audience sees today. Revisit together with [restriction scope](restriction-scope.md).
- **Unchanged either way:** FHIR validation of payer feeds at CDXP's ingest, and Collaborate's filters at staging.
