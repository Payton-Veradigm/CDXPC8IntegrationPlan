# Port TRX's stored procedures to the shared tables

[Back to steps](../steps.md)

- **Who:** CDXP ports them into the `cdxp` database project, and Collaborate checks the logic.
- Scope every statement to one tenant, following CIEP's four rules.
- Replace the 11 Portal references, and the three-part names in Emblem's post-deployment scripts.
- Re-check SQL Server 2016-era syntax at Azure SQL's compatibility level 150.
- Don't port the 119 cumulative post-deployment scripts. Turn their customer-specific parts into tenant-keyed data scripts.
- **Size:** the `alert` schema alone has 36 procedures and 30 views, and `report` has 9 procedures and 13 views.
