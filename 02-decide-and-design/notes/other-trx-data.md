# Decide what happens to TRX's other data

[Back to steps](../steps.md)

- **Moves with the gaps (lean):** the configuration that staging reads:
  - Detail types and their filter rules.
  - LOB settings and feedback types.
  - Diagnosis filters and targeting lists.
  - Document routing.
- **For Collaborate to decide:** where practice enrollment and Core Services files (the `core` schema) go: the shared database or Portal.
- **Retire or replace (lean):** the legacy Popul8 tables (`popul8`) and the operational `dbo` tables.
- **Reporting** (the `report` and `snowflake` schemas): see [the reporting decision](../../08-migrate-everyone/notes/reporting-target.md).
