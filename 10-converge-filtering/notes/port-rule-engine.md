# Port the rule engine

[Back to steps](../steps.md)

- **Collaborate's filter rules,** stored as JSON on each detail type:
  - Filter types: ExcludeGap, IncludeGap, IncludeCondition, ExcludeCondition, and InclusiveAllConditions.
  - Modifiers: Unless, MappingConditions, and ReferenceConditions.
- **Value sources** that look up tables at run time, re-pointed at the shared tables.
- **Lists and rule tables:** targeting lists, diagnosis filters, sensitive-diagnosis suppression, and CMS model mappings.
- **CDXP's model checks,** if they join the same engine: `GapModels`, `RestrictiveModels`, and model-deactivation expiry.
- **Other logic:** Call to Action enrichment, matching and de-duplication, and the LOB and publish-scope settings.
- **The admin screens** that edit all of it.
