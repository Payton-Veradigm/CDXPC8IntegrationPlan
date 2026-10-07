# Decide when the C8-family payers move

[Back to steps](../steps.md)

- **The C8 family:** BCBSMI, BCBSHorizon, CCOK, Christus, Admirian, and Xanthus. CDXP gets their gaps from Collaborate's FHIR Publish today.
- **The overlap:** these customers are also Collaborate payers, so their gaps will also arrive through the cut-in ([phase 5](../../05-cut-in-and-verify/steps.md)). Two copies of the same gap would collide in the shared tables.
- **Options:**
  - A. Move their FHIR Publish parse onto the consolidated tables as CIEP planned, then fold those rows into the cut-in rows.
  - B. Don't move the FHIR Publish parse. Their gaps come in through the cut-in, and their per-payer tables retire with CDXP's old code (phase 9), once the old paths are off.
- **Lean:** B, so each gap lands in the shared tables only once.
