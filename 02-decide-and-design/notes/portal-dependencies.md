# Decide what happens to TRX's reads of the Portal database

[Back to steps](../steps.md)

- **Why:** 11 TRX objects and one post-deployment script read the Portal database directly, and Azure SQL can't query across databases.
- **What they read:**
  - FHIR Publish rules and batches.
  - The member and provider rosters, and the customer table.
  - Reference data: LOBs, coding models, sensitive diagnoses, the ICD crosswalk, zip codes, visible content, and `VeradigmClient`.
  - SSO permission mappings and user permissions.
- **Options, per object:**
  - Copy the Portal table into `cdxp`.
  - Move the table into `cdxp`.
  - Pass the data in from the app.
  - Retire the object.
- **Lean:**
  - Retire the FHIR Publish objects instead of porting them. Phase 7 removes them, and a Collaborate-only pilot doesn't need them.
  - Copy the reference data.
  - Decide the permission and roster data with Security.
- **Also decide:** whether Portal stays on the VMs. The lean is yes, for now.
