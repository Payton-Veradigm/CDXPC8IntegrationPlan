# Decide who runs staging and filtering during the merge

[Back to steps](../steps.md)

- **Why:** both products filter gaps today. Without one owner, filtering gets built twice.
- **Options:**
  - A. Collaborate's existing engine, pointed at the shared tables.
  - B. A new CDXP pipeline, built on Payer Automation's configuration.
  - C. Snowflake (HNA Gold). Scott Ackerson took this position in the September sessions.
- **Lean:** A for the merge. Decide the long-term owner later, in [phase 10](../../10-converge-filtering/steps.md).
- **Stays with CDXP either way:** its own intake checks: FHIR validation, restrictive models, and model-deactivation expiry.
- **Related:** [which restrictions apply](restriction-scope.md) and [where they run](restriction-order.md).
