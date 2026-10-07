# Decide how each product reaches the data

[Back to steps](../steps.md)

- **Options:**
  - A. Direct SQL, through a contract of views and stored procedures.
  - B. A shared service API for all reads and writes. This is Jason's proposal.
  - C. Hybrid. Each product reads and writes its own tables directly. Anything that crosses ownership goes through a procedure or an API.
- **Trade-offs:**
  - B decouples the releases best. But it turns Collaborate's EF Core and Dapper data access into HTTP calls, and someone has to run the service.
  - A is fastest, but ties both release cycles to one schema.
- **Lean:** A, with CDXP owning the contract. Collaborate's app reads and writes through CDXP-owned procedures and views. Revisit an API after the pilot.
