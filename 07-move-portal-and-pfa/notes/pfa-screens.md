# Point the PFA screens and feedback at the new source

[Back to steps](../steps.md)

- Swap the PFA's data access (EF Core `AlertContext` and Dapper) for the contract's reads and writes.
- **Screens:** the member grid, gap details, KPIs, feedback, and "not seen here".
- **Dates:** the new tables are UTC, so convert for display. The app uses `DateTime.Now` in many places today.
- **Check:** each screen shows the same thing for a moved customer as it did on TRX.
