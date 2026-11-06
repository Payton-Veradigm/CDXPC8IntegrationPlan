# Move a copy of the Portal database into CDXP

[Back to steps](../steps.md)

- **Why:** TRX's staging and publish read the Portal database ([what they read](../../02-decide-and-design/notes/portal-dependencies.md)). A copy in CDXP gives CDXP's process those inputs without a per-item sync job, and lets the PFA build start on one backend.
- **What moves:** a copy. The Portal keeps running on its current database until each customer's PFA cutover (phase 7).
- **When:** at the start of the PFA build (phase 7), once the shared data model build is done and the dev work on Collaborate's master-record removal is done (mid-December 2026). It's a quick step.
- **Replaces:** the earlier plan to copy the reference data and rules into `cdxp` with a sync job. The FHIR Publish rules still retire when FHIR Publish stops (phase 7).
- **Work:** assess the database for Azure SQL, copy the schema and data with DBOps, and keep the copy current until cutover. The Portal, PFA, SSO, and nightly jobs re-point to it at cutover.
- **Decided:** move a copy of the whole Portal database into CDXP in phase 3 (2026-11-05, Payton Obrycki).
- **Open:**
  - How the copy stays current until cutover.
  - Whether it lands as its own database next to CDXP's, or as a schema inside it. That decides whether `cdxp` can read Portal tables directly, which changes [the access contract](../../07-move-portal-and-pfa/notes/access-contract.md).
  - Permission and roster data, with Security.
  - The estimate is a starting guess.
