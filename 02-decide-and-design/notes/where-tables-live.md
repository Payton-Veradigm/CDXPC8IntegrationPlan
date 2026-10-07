# Decide where the shared tables live

[Back to steps](../steps.md)

- **Decided (2026-10-07, per Payton Obrycki):** in CDXP's consolidated bulk tables, in the `cdxp` database.
- **Options considered:**
  - A. New tables in the existing `cdxp` database.
  - B. A separate database on the same server. Azure SQL can't join across databases, so we'd lose the joins to payers, sites, NPIs, and matching.
  - C. Snowflake (HNA) as the write path. Jason's proposal argued against it, because the PFA needs an operational store.
  - D. Keep one database per customer, moved to Azure SQL. This is still the fallback if compliance rejects shared tables.
- **What `cdxp` runs on:** Azure SQL Hyperscale serverless, up to 40 vCores, compatibility level 150, with CDC on. That holds in PROD and Cadmium, per CIEP #169995.
