# Replace FHIR Publish with a "visible to point of care" flag

[Back to steps](../steps.md)

- Collaborate's publish sets the flag and a publish version, after CTQ sign-off.
- CDXP serves VPI and EHRs from the flagged gaps, grouped by NPI.
- PayerPath delta and IFGapStats read the same flags.
- Expire-by-absence is replaced by whatever [the FHIR Publish decision](replace-fhir-publish.md) picks.
