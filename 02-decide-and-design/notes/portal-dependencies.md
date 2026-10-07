# Decide how CDXP's process gets the Portal data it needs

[Back to steps](../steps.md)

- **Why:** TRX's staging and publish read data from the Portal database. Once CDXP's process does the staging, it needs the same inputs.
- **What TRX reads from Portal today:**
  - FHIR Publish rules (gap inclusion and NPI exclusion).
  - The member and provider rosters, and the customer table.
  - Reference data: LOBs, coding models, sensitive diagnoses, and the ICD crosswalk.
  - SSO permission mappings, which are used to build access.
- **Options, per item:**
  - Copy it into `cdxp` with a sync job.
  - Read it through an API.
  - Retire it.
- **Lean:**
  - Copy the reference data and rules.
  - Retire the FHIR Publish rules once FHIR Publish stops, as customers move (phase 7).
  - Decide the permission and roster data with Security.
