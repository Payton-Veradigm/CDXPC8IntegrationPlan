# Implement Collaborate's filtering rules in CDXP's process

[Back to steps](../steps.md)

- **Filter rules,** stored as JSON on each detail type:
  - Filter types: ExcludeGap, IncludeGap, IncludeCondition, ExcludeCondition, and InclusiveAllConditions.
  - Modifiers: Unless, MappingConditions, and ReferenceConditions.
- **Value sources:** rules that look up tables at run time. Point them at data that exists in `cdxp`, and make a failed lookup fail the run. Today a failed lookup only logs a warning.
- **Lists and rule tables:** targeting lists, diagnosis filters, sensitive-diagnosis suppression, and CMS model mappings.
- **Other staging logic:** Call to Action enrichment, matching and de-duplication, and the LOB and publish-scope settings.
- **Configuration:** per [the configuration decision](../../02-decide-and-design/notes/restriction-config.md).
- **Collaborate's part:** explain the rules and check the output.
