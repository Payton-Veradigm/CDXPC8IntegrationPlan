# Decide what code and schema the teams share

[Back to steps](../steps.md)

- **At minimum:** the shared tables' schema, and the procedures or views that cross ownership.
- **Maybe:** shared C# libraries (data access, tenant context, models) and test tooling.
- **Options:**
  - A. Separate repos, plus one shared database project.
  - B. Separate repos, with each team owning its own tables in the shared database.
  - C. One repo for the shared pieces, used by both teams.
- **Lean:** share as little as possible at first: the schema and the access contract. Revisit after the pilot.
- **Drives:** the other decisions in this phase.
