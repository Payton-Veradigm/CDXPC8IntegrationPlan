# Update what reads TRX outside the app

[Back to steps](../steps.md)

- **Why:** anything that still reads `alert.Master` breaks when the retired master objects are dropped.
- **Known readers** (from [the consumer list](consumer-inventory.md)):
  - CTQ's SQL scripts and the OTB queue validation query, which people run in SSMS.
  - The `snowflake` views that UDP reads, including finance member counts and the provider feedback used for risk adjustment.
  - Power BI datasets (one workspace per customer) and the Care Gap Utilization Dashboard.
  - Team Banyan's stream, if it reads TRX.
- **Where the branch changed the `snowflake` views,** check that UDP still reads them. Keeping columns stable where possible means UDP and Power BI change only once more, when they move to the shared tables (phase 7).
- **With:** Team Banyan and the UDP owners.
