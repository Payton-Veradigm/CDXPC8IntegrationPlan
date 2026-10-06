# Decide when the C8-family payers move

[Back to steps](../steps.md)

- **The C8 family:** BCBSMI, BCBSHorizon, CCOK, Christus, Admirian, and Xanthus. They get their gaps only from Collaborate.
- **CIEP's plan:** only the parsing of Collaborate's publish moves. OTB stays as it is.
- **Options:**
  - A. Move them as planned, then fold their rows into Collaborate's rows later.
  - B. Wait until Collaborate writes to the shared tables directly (phase 7).
- **Lean:** A, but only if the shared rows carry the platform gap ID and Collaborate's own IDs. Then the later fold is an update, not a second migration. Otherwise, B.
