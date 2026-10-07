# Decide whether to move data first or rebuild the pipeline first

[Back to steps](../steps.md)

- **Decided (2026-10-07, per Payton Obrycki):** pipeline first, in CDXP. The plan runs in three stages:
  1. Collaborate's payers are cut into CDXP's process.
  2. They're checked side by side against TRX until the data matches.
  3. Then the Portal and PFA move to the new source.
- **Options considered:**
  - A. Pipeline first (Jason's proposal): CDXP replaces Collaborate's staging and publish.
  - B. Data first: Collaborate's staging keeps running, pointed at the shared tables.
- **What it means:**
  - Collaborate's filtering rules get rebuilt in CDXP's process ([phase 5](../../05-cut-in-and-verify/steps.md)).
  - TRX stays the source for the Portal and PFA until each customer moves.
