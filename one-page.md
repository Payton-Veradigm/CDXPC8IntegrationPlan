# CDXP + Collaborate integration: the plan on a page

**Goal:** members, providers, and gaps for both products live in one set of shared, tenant-partitioned tables in CDXP's Azure SQL database. Both teams design the model, and CDXP builds it. Collaborate's payers are then cut in and checked against TRX, and finally the Portal and PFA move to the new source.

Estimates are effort per team, in dev hours (LLM-assisted) and decision hours. See the [README](README.md). C8 is the Collaborate team.

1. **[Prerequisites](01-prerequisites/steps.md)**: Collaborate's master-record removal released, the CDXP team's spec builder, ingestor, and consolidated tables in place (its own project), owners named, and the facts gathered.
   - C8 122 dev h, 5 decision h | CDXP 6 dev h, 4 decision h | CDXP team project not counted
2. **[Design the shared data model](02-decide-and-design/steps.md)**: both teams meet and design the model, and settle the decisions it depends on, including ingestion restrictions. Agreed as of 2026-11-05.
   - C8 14 dev h, 76 decision h | CDXP 54 dev h, 74 decision h
3. **[Implement the shared data model](03-build-foundation/steps.md)**: Starting during the CDXP team's Payer Automation build, CDXP builds the model into the consolidated bulk tables, with isolation and PHI protection. Brian folds these changes into his unified data model. It doesn't wait on the master-record removal.
   - C8 72 dev h, 16 decision h | CDXP 180 dev h, 18 decision h
4. **[Move CDXP's bulk payers](04-move-cdxp-payers/steps.md)**: CDXP's bulk payers (all but Humana) on the consolidated tables, their per-payer tables retired, and the consolidated tables pushed to HNA. Starts after the shared data model build, and runs continuously alongside phase 5.
   - C8 0 dev h, 1 decision h | CDXP 244 dev h, 3 decision h
5. **[Cut in Collaborate payers and verify against TRX](05-cut-in-and-verify/steps.md)**: Collaborate's payers flow through CDXP's process one at a time, side by side with TRX, until the data matches. Includes multi-headed OTB and the ANR feed with RAA.
   - C8 64 dev h, 20 decision h | CDXP 388 dev h, 20 decision h
6. **[Agree how we build and release together](06-build-and-release-together/steps.md)**: one way of working before the Portal and PFA depend on the new source. Josh and Payton, 3 weeks or less, at the start.
   - C8 12 dev h, 31 decision h | CDXP 20 dev h, 31 decision h
7. **[Move the Portal and PFA to the new source](07-move-portal-and-pfa/steps.md)**: Once phase 3 is done and Jason's master-record dev work is done (mid-December), Collaborate moves a copy of the Portal database into CDXP and builds the PFA on the new backend in 5 to 6 weeks. Once a customer's data matches, it points the Portal and PFA at the shared tables, one customer at a time. The point of care and soft closure move with it.
   - C8 280 dev h, 9 decision h | CDXP 264 dev h, 7 decision h
8. **[Turn off the old paths](08-turn-off-old-paths/steps.md)**: the old OTB and CORE feeds into TRX stop, customer by customer, and the old endpoints retire.
   - Merged team 32 dev h, 2 decision h
9. **[Retire the old pieces](09-retire/steps.md)**: TRX databases archived, old code removed, and VM capacity released.
   - Merged team 74 dev h, 2 decision h

**Totals:** C8 564 dev h, 158 decision h | CDXP 1156 dev h, 157 decision h | Merged team 106 dev h, 4 decision h

**In work days (8 hours each):** C8 about 71 dev days and 20 decision days | CDXP about 145 dev days and 20 decision days | Merged team about 13 dev days and half a decision day. About 268 work days in all.

**Calendar, with phases overlapped:** about 40 weeks from 2026-11-05, to mid-August 2027. The first customer moves in late March 2027. Dependencies, monthly side-by-side cycles, and soaks set most of it, not team size. See [the timeline](timeline.md).

**Not in the hours:**
- The CDXP team's own project.
- Calendar time for sign-offs, side-by-side cycles, and soaks.
- Time from DBOps, DevOps, Security, Compliance, RAA, and Team Banyan.

**Critical path:** the CDXP team's project, then the shared design, CDXP's build, side-by-side parity for each payer, and the Portal and PFA move.
