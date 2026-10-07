# Decide who owns the shared schema and how each team deploys

[Back to steps](../steps.md)

- **Options:**
  - A. One database project in the `cdxp` repo, owned by CDXP. Collaborate reviews changes to the tables its app uses.
  - B. Collaborate keeps its own database project for its tables, deployed into the same database on its own schedule.
- **Lean:** A, since CDXP builds the shared model in its codebase.
- **Then decide:** how a Collaborate release that needs a schema change gets that change shipped first.
