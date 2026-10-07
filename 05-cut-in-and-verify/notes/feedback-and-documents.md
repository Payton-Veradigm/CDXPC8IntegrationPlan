# Decide how PFA feedback and documents reach the shared tables

[Back to steps](../steps.md)

- **Why:** until a customer moves, the PFA keeps writing feedback and documents to TRX.
- **Options:**
  - A. A one-time copy for each customer when it moves. The side-by-side check then covers the ingested data only.
  - B. An ongoing sync from TRX during the side-by-side run, so the new tables match on feedback too.
- **Trade-offs:**
  - A is simpler, but gap states that depend on feedback (responded, closed) can't be compared until the move.
  - B checks more, but means building and running a sync.
- **Lean:** none yet. This is open as of 2026-10-07.
