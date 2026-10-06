# CDXP + Collaborate integration: the plan on a page

**Goal:** members, providers, and gaps for both products live in one set of shared, tenant-partitioned tables in CDXP's Azure SQL database. The products stop sending gaps back and forth, and Collaborate's TRX databases come off the SQL Server VMs.

Estimates are effort per team, in dev hours (LLM-assisted) and decision hours. See the [README](README.md). C8 is the Collaborate team.

1. **[Prerequisites](01-prerequisites/steps.md)**: the two team projects done (Collaborate's master-record removal; CDXP's spec builder, ingestor, and consolidated tables), owners named, and the facts gathered.
   - C8 14 dev h, 9 decision h | CDXP 10 dev h, 8 decision h | team projects not counted
2. **[Decide and design](02-decide-and-design/steps.md)**: the big decisions made, including ingestion restrictions (Collaborate's filtering, CDXP's model filtering), and one data model both teams agree to build.
   - C8 30 dev h, 84 decision h | CDXP 38 dev h, 79 decision h
3. **[Agree how we build and release together](03-build-and-release-together/steps.md)**: one way of working for shared code and schema. Runs alongside phase 2.
   - C8 20 dev h, 42 decision h | CDXP 28 dev h, 42 decision h
4. **[Build the shared foundation](04-build-foundation/steps.md)**: CDXP's consolidated tables extended for Collaborate, with isolation, PHI protection, and migration tooling.
   - C8 104 dev h, 10 decision h | CDXP 196 dev h, 12 decision h
5. **[Move CDXP's bulk payers](05-move-cdxp-payers/steps.md)**: CDXP's bulk payers (all but Humana) on the consolidated tables, and their per-payer tables retired. Overlaps phases 6 and 7.
   - C8 0 dev h, 1 decision h | CDXP 220 dev h, 3 decision h
6. **[Pilot one Collaborate customer](06-pilot-collaborate/steps.md)**: one Collaborate-only customer runs a full monthly cycle on the shared tables.
   - C8 314 dev h, 8 decision h | CDXP 32 dev h, 6 decision h
7. **[Remove the round trips](07-remove-round-trips/steps.md)**: OTB, Centene CORE, FHIR Publish, and soft closure stop moving gaps between the products.
   - C8 76 dev h, 8 decision h | CDXP 160 dev h, 9 decision h
8. **[Migrate everyone else](08-migrate-everyone/steps.md)**: every live customer moved, and reporting, UDP, and Power BI re-pointed.
   - Merged team 320 dev h, 12 decision h
9. **[Retire the old pieces](09-retire/steps.md)**: TRX databases archived, old code removed, and VM capacity released.
   - Merged team 74 dev h, 2 decision h
10. **[Converge filtering (optional)](10-converge-filtering/steps.md)**: one engine for Collaborate's filtering and CDXP's model checks, if we decide it's worth it.
    - Merged team 240 dev h, 10 decision h

**Totals, phases 1 to 9:** C8 558 dev h, 162 decision h | CDXP 684 dev h, 159 decision h | Merged team 394 dev h, 14 decision h

**In work days (8 hours each):** C8 about 70 dev days and 20 decision days | CDXP about 86 dev days and 20 decision days | Merged team about 49 dev days and 2 decision days. About 246 work days in all.

**Not in the hours:** the two team projects; calendar time for sign-offs, soaks, and monthly cycles; and time from DBOps, DevOps, Security, and Compliance.

**Critical path:** the two team projects, then compliance sign-off, the shared foundation, the pilot, the round trips, and the migration waves.
