# 5. Cut in Collaborate payers and verify against TRX

[Back to the one-page plan](../one-page.md)

Collaborate's payers flow through CDXP's process into the shared tables, one at a time, side by side with TRX, until the data matches.

## Build the new process for Collaborate's data

- [ ] [Implement Collaborate's filtering rules in CDXP's process](notes/c8-filtering.md) (C8 20 + CDXP 140 dev h)
- [ ] [Apply CDXP's model checks as decided](notes/model-checks.md) (CDXP, 16 dev h)
- [ ] [Work with RAA to feed ANR data into CDXP's process](notes/anr-feed.md) (C8 4 + CDXP 24 dev h, with RAA)
- [ ] [Make OTB multi-headed](notes/otb-multi-headed.md) (CDXP, 32 dev h)
- [ ] [Make Centene CORE multi-headed](notes/centene-core-multi-headed.md) (CDXP, 16 dev h)
- [ ] [Build CTQ review into CDXP's process, as decided](notes/ctq-in-cdxp.md) (C8 8 + CDXP 32 dev h)
- [ ] [Build the side-by-side comparison with TRX](notes/parity-comparison.md) (C8 8 + CDXP 40 dev h)

## Decide

- [ ] [**Decide** which Collaborate customers are cut in, and how much history moves](notes/migration-scope.md) (Both, 2 decision h each, with Compliance)
- [ ] [**Decide** what counts as parity](notes/parity-criteria.md) (Both, 3 decision h each)
- [ ] [**Decide** the order Collaborate payers are cut in](notes/cut-in-order.md) (Both, 2 decision h each)
- [ ] [**Decide** how PFA feedback and documents reach the shared tables](notes/feedback-and-documents.md) (Both, 4 decision h each)

## Cut in and verify

- [ ] [Cut in the first payer and run a full cycle side by side](notes/first-cut-in.md) (C8 8 + CDXP 24 dev h)
- [ ] [Cut in the remaining payers](notes/remaining-cut-ins.md) (C8 16 + CDXP 64 dev h)
- [ ] [Sign off parity for each payer](notes/parity-sign-off.md) (Both, 9 decision h each)

**Phase total:** C8 64 dev h, 20 decision h | CDXP 388 dev h, 20 decision h
