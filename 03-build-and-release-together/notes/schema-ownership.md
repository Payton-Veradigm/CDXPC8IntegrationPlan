# Decide who owns the shared schema and how each team deploys

[Back to steps](../steps.md)

- **Options:**
  - A. One database project in the `cdxp` repo, with Collaborate reviewing changes to its tables.
  - B. Collaborate keeps its own database project for its tables, deployed into the same database on its own schedule.
- **Trade-offs:**
  - A is one source of truth, but ties Collaborate's weekly releases to CDXP's.
  - B keeps the schedules independent, but two projects in one database need strict boundaries so that neither drops the other's objects.
- **Lean:** open. Go with B if the release schedules can't line up.
