# CDXP team: build the spec builder, ingestor, and consolidated bulk tables

[Back to steps](../steps.md)

- **What it is:** the CDXP team's own project: CIEP's Payer Spec and Automation work (Epic #170061, led by Brian Fontana).
  - **Spec builder** (#170062, Active): a versioned spec registry. Payers validate against a managed spec version.
  - **Ingestor** (#169995): a generic parser that maps a payer's file or FHIR feed through configuration, with no code change and no deployment.
  - **Consolidated tables** (#169995): one set of `cdxp.BulkPayer*` tables for every bulk payer, with one partition per payer.
- **Why this plan depends on it:**
  - The shared data model is built into these tables (phase 3).
  - The ingestor is the process that Collaborate's payers are cut into (phase 5).
- **Today:** the 13 bulk payers use 113 tables and 262 stored procedures between them.
- **Status:** Payer Automation is New. No branch had the tables yet when we checked on 2026-09-30.
- **Hours:** the CDXP team's own estimate. They aren't counted in this plan.
