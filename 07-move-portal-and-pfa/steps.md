# 7. Move the Portal and PFA to the new source

[Back to the one-page plan](../one-page.md)

Once a customer's data matches TRX, Collaborate points the Portal and PFA at the shared tables for that customer, one customer at a time. The point of care and soft closure move at the same time.

## Build

- [ ] [Build the reads and writes the Portal and PFA need](notes/access-contract.md) (C8 16 + CDXP 80 dev h)
- [ ] [Add a per-customer switch where the Portal and PFA connect](notes/storage-switch.md) (C8, 24 dev h)
- [ ] [Point the PFA screens and feedback at the new source](notes/pfa-screens.md) (C8, 40 dev h)
- [ ] [Point the Portal's admin screens at the new source](notes/admin-screens.md) (C8, 24 dev h)
- [ ] [Serve VPI and the other point-of-care channels from the shared tables](notes/visible-flag.md) (C8 8 + CDXP 64 dev h)
- [ ] [Move soft-closure feedback to a direct write](notes/soft-closure.md) (C8 4 + CDXP 20 dev h)
- [ ] [Make the nightly jobs work against the new source](notes/nightly-jobs.md) (C8, 24 dev h)
- [ ] [**Decide** where chart files live](notes/chart-files.md) (C8 3 + CDXP 1 decision h)
- [ ] [Move chart files to Blob Storage](notes/chart-files-to-blob.md) (C8 20 + CDXP 12 dev h)
- [ ] [Copy each customer's feedback, documents, and history](notes/history-copy.md) (C8 8 + CDXP 32 dev h)
- [ ] [Re-point the CTQ and OTB scripts](notes/ops-scripts.md) (C8, 16 dev h)

## Move

- [ ] [**Decide** how cutover and rollback work](notes/cutover-and-rollback.md) (Both, 3 decision h each)
- [ ] [Move the first customer, then the rest](notes/move-customers.md) (C8 40 + CDXP 16 dev h)

## Reporting and onboarding

- [ ] [**Decide** where reporting and analytics read from](notes/reporting-target.md) (Both, 3 decision h each, with Team Banyan)
- [ ] [Re-point reporting, UDP, and Power BI](notes/reporting.md) (C8 48 + CDXP 32 dev h)
- [ ] [Update customer onboarding](notes/onboarding.md) (C8 8 + CDXP 8 dev h)

**Phase total:** C8 280 dev h, 9 decision h | CDXP 264 dev h, 7 decision h
