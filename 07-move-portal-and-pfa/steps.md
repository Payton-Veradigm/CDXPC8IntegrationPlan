# 6. Cut over one Collaborate customer (pilot)

[Back to the one-page plan](../one-page.md)

Collaborate's first cutover: one Collaborate-only customer runs a full monthly cycle on the shared tables, with its TRX database kept for rollback.

- [ ] [Confirm the master-record removal is in Prod](notes/master-record-in-prod.md) (C8, 2 dev h)
- [ ] [**Decide** the pilot customer](notes/pilot-customer.md) (Both, 2 decision h each)
- [ ] [Port TRX's stored procedures to the shared tables](notes/port-procedures.md) (C8 16 + CDXP 120 dev h)
- [ ] [Fix the clock, lock, and collation differences](notes/clock-locks-collation.md) (C8 16 + CDXP 24 dev h)
- [ ] [Prove Collaborate's filters give the same results on the shared tables](notes/filter-parity.md) (C8 8 + CDXP 8 dev h)
- [ ] [Add a per-customer switch where Collaborate connects](notes/storage-switch.md) (C8, 24 dev h)
- [ ] [Make the nightly jobs work per customer in one database](notes/nightly-jobs.md) (C8, 32 dev h)
- [ ] [**Decide** where chart files live](notes/chart-files.md) (C8 3 + CDXP 1 decision h)
- [ ] [Move chart files to Blob Storage](notes/chart-files-to-blob.md) (C8 20 + CDXP 12 dev h)
- [ ] [**Decide** how cutover and rollback work](notes/cutover-and-rollback.md) (Both, 3 decision h each)
- [ ] [Migrate the pilot and run a month in Stage, then Prod](notes/run-the-pilot.md) (C8 24 + CDXP 24 dev h)
- [ ] [Re-point the CTQ and OTB scripts](notes/ops-scripts.md) (C8, 16 dev h)

**Phase total:** C8 158 dev h, 8 decision h | CDXP 188 dev h, 6 decision h
