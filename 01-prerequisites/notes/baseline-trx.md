# Baseline every TRX database

[Back to steps](../steps.md)

- **Why:** we don't know how much data there is, or which databases are still live.
- **What we know:**
  - `db/DatabaseConfig.json` lists 24 TRX databases: 20 customers, plus 4 stage, test, or de-identified copies.
  - The Customer Overview (2026-08-06) lists 9 configured customers.
- **For each database, record:**
  - Whether it's live or dormant.
  - Its size, and row counts for members, gaps, history, documents, queues, staging, and targeting.
  - The total chart bytes in `alert.Document.[File]`. Charts are stored inside the database.
  - Its collation.
- **Also record:** the time zone of the SQL Server VMs. TRX code assumes local time, and Azure SQL runs in UTC.
- **Start from what's already known.** These are simple size statistics and statuses, and some may already be on hand.
- **Who:** Collaborate, with DBOps.
