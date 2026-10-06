# Decide what replaces FHIR Publish

[Back to steps](../steps.md)

- **Today:** Collaborate publishes gaps to CDXP per NPI. CDXP parses them into its payer tables and expires anything that's missing, unless more than 20% would expire.
- **Proposal:** Collaborate's publish marks gaps "visible to point of care", with a publish version. CDXP reads those gaps directly, by tenant and NPI.
- **Decide:**
  - What replaces expire-by-absence and the 20% guard.
  - How the PCP-based publish scope applies.
  - Whether visibility is stored on each gap, or derived from the gap's state plus the latest signed-off publish.
