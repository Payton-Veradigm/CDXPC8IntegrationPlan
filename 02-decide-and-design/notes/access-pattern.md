# Decide how the Portal and PFA will reach the data

[Back to steps](../steps.md)

- **Options:**
  - A. Direct SQL, through a contract of CDXP-owned views and stored procedures.
  - B. A shared service API for all reads and writes. This is Jason's proposal.
  - C. Hybrid: direct reads of some tables, with procedures or an API for anything that crosses ownership.
- **Trade-offs:**
  - B decouples releases best. But it turns the PFA's EF Core and Dapper data access into HTTP calls, and someone has to run the service.
  - A is fastest, but ties the Portal's releases to the shared schema.
- **Lean:** A, with CDXP owning the contract. Revisit an API after the first customers move.
