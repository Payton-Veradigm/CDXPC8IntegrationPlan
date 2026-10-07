# Serve VPI and the other point-of-care channels from the shared tables

[Back to steps](../steps.md)

- Build what [the FHIR Publish decision](../../02-decide-and-design/notes/replace-fhir-publish.md) picks: a "visible to point of care" flag and a publish version, set after CTQ sign-off.
- CDXP serves VPI and EHRs from the visible gaps, grouped by NPI, instead of from FHIR Publish.
- A per-customer setting picks the source, so each customer switches as part of [its move](move-customers.md). FHIR Publish stops for that customer.
- PayerPath delta and IFGapStats read the same flags.
- Replace expire-by-absence the way the decision says.
- **Collaborate's part:** check that a moved customer's point of care shows what FHIR Publish would have sent.
