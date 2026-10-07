# Migrate the remaining payers

[Back to steps](../steps.md)

- Twelve payers move in total: every bulk payer except Humana, which stays on custom code.
- **C8 family:** BCBSMI, BCBSHorizon, CCOK, Christus, and Admirian, after Xanthus. They move here only under option A of [the C8-family decision](c8-family-timing.md). These hours assume option A; under the lean, the C8-family part drops out.
- **Others:** Agilon, Centene, HPP, and Optum. IHC and Inovalon go first.
- **Migration stories include:** #170111 (Centene), #170112 (Xanthus), and #170117 (BCBSMI).
- **Size:** the twelve hold about 4.5 million gaps and 5.2 GB in PROD.
- **Estimate basis:** about 4 dev h for each of the 9 remaining payers. The first payer of each kind has already proven the map, the history copy, and the cutover, so the rest is mostly configuration and running the same tools.
