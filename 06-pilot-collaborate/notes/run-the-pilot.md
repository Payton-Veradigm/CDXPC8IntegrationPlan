# Migrate the pilot and run a month in Stage, then Prod

[Back to steps](../steps.md)

- Migrate the pilot and reconcile it, with row counts and checksums per table.
- Run a full monthly cycle: stage, CTQ review, publish, PFA feedback, chart pull, and reports.
- Do it in Stage first, then in Prod.
- **Calendar time:** one monthly cycle in each environment. This isn't counted in the hours.
- **Done when:**
  - CTQ passes.
  - Reconciliation is clean.
  - Rollback has been rehearsed.
