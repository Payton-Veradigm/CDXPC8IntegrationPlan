# Map both products' ingestion restrictions side by side

[Back to steps](../steps.md)

- **Why:** both products drop or hide gaps before providers see them, using different rules. The merged flow needs one agreed set.
- **Collaborate's filtering (per customer, at staging):**
  - Filter rules stored as JSON on each detail type (`DetailType.Filters`): include and exclude rules for gaps and conditions, with modifiers.
  - Value sources: rules that look up tables at run time. A failed lookup only logs a warning.
  - Diagnosis code filters, sensitive-diagnosis suppression, and CMS model mappings.
  - Targeting lists, which payer users edit.
  - Publish scope: which detail types go to FHIR Publish, plus the gap-inclusion and NPI-exclusion rules.
  - Outcomes are logged in `alert.DetailStagingFilterLog`.
- **CDXP's model filtering (all payers, at ingest):**
  - FHIR validation against the spec. Only "enforced" errors drop a gap.
  - Model check: a gap's clinical codes have to map to a known model in `cdxp.GapModels`.
  - Restrictive codes (`cdxp.RestrictiveModels`): a gap whose code is restricted for its model is rejected. The list is global, not per payer.
  - Deactivating a model expires its gaps (`MODEL_EXPIRY`).
  - Collaborate's intake accepts only 6 of CDXP's 7 gap types.
  - Failures are logged, for example in `cdxp.BulkValidationFailures`.
- **Effect today:** a gap can pass Collaborate's filters and show in the PFA, but still be dropped by CDXP before it reaches VPI.
