# Decide where the shared tables live

[Back to steps](../steps.md)

- **Direction given:** central tables in CDXP's `cdxp` database (Azure SQL), partitioned by payer or customer.
- **Options:**
  - A. New tables in the existing `cdxp` database. This is the direction given.
  - B. A separate database on the same server. Azure SQL can't join across databases, so we'd lose the joins to payers, sites, NPIs, and matching.
  - C. Snowflake (HNA) as the write path. Jason's proposal argues against it, because the PFA needs an operational store.
  - D. Keep one database per customer, but move them to Azure SQL. This is the fallback if compliance rejects shared tables.
- **Lean:** A.
- **What `cdxp` runs on:** Azure SQL Hyperscale serverless, up to 40 vCores, compatibility level 150, with CDC on. That holds in PROD and Cadmium, per CIEP #169995.
