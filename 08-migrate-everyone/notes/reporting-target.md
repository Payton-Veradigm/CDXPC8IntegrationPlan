# Decide where reporting and analytics read from

[Back to steps](../steps.md)

- **Lean:**
  - Operational reports read the shared tables through a read replica, or through CDXP's `rpt` projections.
  - Analytics read Snowflake, through one change feed from the shared tables: HNA sync, Team Banyan's stream, or both.
- **Also decide:**
  - What replaces TRX's seven `snowflake` views.
  - Whether Collaborate's `report` rollup tables stay, keyed by tenant, to limit Power BI changes.
  - How Power BI's per-customer workspaces get their data.
