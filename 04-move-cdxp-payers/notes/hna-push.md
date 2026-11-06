# Push the consolidated (PA and shared data model) tables to HNA

[Back to steps](../steps.md)

- **Why:** HNA starts with the initial bulk uploads. After the shared data model build, the consolidated tables (Payer Automation's tables, extended with the shared model) are the data HNA should get.
- **When:** starts with the payer migration, once the shared data model build is done, and grows as each payer moves onto the consolidated tables. Collaborate's payers join as they're cut in (phase 5) and their customers move (phase 7).
- **Builds on:** the initial HNA bulk uploads, Payer Automation's HNA sync (PA-19), and [where reporting reads from](../../07-move-portal-and-pfa/notes/reporting-target.md).
- **Open:**
  - Who owns HNA's side.
  - Whether it's a schema push, a change feed, or both.
  - The estimate is a starting guess.
