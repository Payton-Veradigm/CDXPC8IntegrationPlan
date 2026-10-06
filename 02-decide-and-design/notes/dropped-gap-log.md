# Decide how a dropped gap is recorded and explained

[Back to steps](../steps.md)

- **Why:** when a provider or payer asks "why don't I see this gap?", the answer is spread across two products.
- **Today:**
  - Collaborate logs filter outcomes for each staging run (`alert.DetailStagingFilterLog`).
  - CDXP logs validation and model failures, for example in `cdxp.BulkValidationFailures`.
- **Lean:** one tenant-keyed record of every drop: the gap, the rule, the run, and when it happened.
- **Also:** make value-source lookup failures visible, rather than only logging a warning.
