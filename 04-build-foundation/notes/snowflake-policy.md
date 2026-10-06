# Decide what the shared tables send to Snowflake

[Back to steps](../steps.md)

- **Why:** registered tables send every change to Snowflake (HNA sync) with no row filter, and the sync decrypts member columns.
- **Decide:**
  - Are Collaborate tenants registered for the sync, and under what policy?
  - How do scratch, parallel-run, and migration rows stay out?
  - One change feed or two, if Team Banyan's stream also reads these tables?
- **Constraints:**
  - Change capture keeps changes for 7 days.
  - Rebuilding a table drops its capture until it's repaired.
- **Today:** HNA sync has run in Cadmium since 2026-08-18, and is off in PROD.
