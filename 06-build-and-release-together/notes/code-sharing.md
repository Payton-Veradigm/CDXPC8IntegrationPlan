# Decide what code and schema the teams share

[Back to steps](../steps.md)

- **Direction:** CDXP builds the shared model, and the process that takes in Collaborate's payers, in its own codebase and release flow. Collaborate then moves the Portal and PFA onto it.
- **Lives in CDXP's codebase:**
  - The shared tables, with their procedures and views.
  - The access contract.
  - The intake of Collaborate's payers, including Collaborate's filtering rules.
  - The migration and comparison tooling.
- **Stays in Collaborate's codebase:** the Portal and PFA's switch to the new source, their jobs, and their screens.
- **Still to decide:** whether any C# code is shared, such as tenant context, data access, or models, or each side keeps its own.
- **Lean:** share only the database project and the access contract, with no shared C# libraries at first.
