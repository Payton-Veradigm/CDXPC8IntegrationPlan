# Decide whether to move data first or rebuild the pipeline first

[Back to steps](../steps.md)

- **Why:** Jason's proposal has CDXP rebuild Collaborate's staging and filtering pipeline before Collaborate moves. That puts the hardest piece on the critical path: matching today's filter rules exactly.
- **Options:**
  - A. Pipeline first, in Jason's order.
  - B. Data first. Collaborate's staging keeps running, pointed at the shared tables. Rebuilding the pipeline becomes a separate, optional project ([phase 10](../../10-converge-filtering/steps.md)).
- **Lean:** B. We get one store, no round trips, and no TRX VMs without rewriting the filter engine.
- **Cost of B:**
  - Collaborate's stored procedures have to be ported to `cdxp`.
  - Two ingest engines run side by side for a while.
- **Needs:** agreement with Jason.
