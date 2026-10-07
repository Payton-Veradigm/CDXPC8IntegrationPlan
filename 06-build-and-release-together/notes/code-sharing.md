# Decide what code and schema the teams share

[Back to steps](../steps.md)

- **Direction:** the shared model is built mostly in CDXP's codebase and release flow, and Collaborate then cuts over to it.
- **Lives in CDXP's codebase:** the shared tables, their procedures and views, the access contract, and the migration tooling.
- **Stays in Collaborate's codebase:** the app's switch to the shared tables, its jobs, and its screens.
- **Still to decide:** whether any C# code is shared, such as tenant context, data access, or models, or each side keeps its own.
- **Lean:** share only the database project and the access contract, with no shared C# libraries at first.
