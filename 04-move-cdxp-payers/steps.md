# 4. Move CDXP's bulk payers

[Back to the one-page plan](../one-page.md)

CDXP's existing bulk payers (all but Humana) moved onto the consolidated tables, and their per-payer tables retired. This is CIEP's Payer Migration plan (#170100). The migration starts once the CDXP team's Payer Automation build is done, and overlaps the rest of the shared data model build (phase 3). Once that build is done, the consolidated tables are pushed to HNA over about 3 weeks, while the last payers finish migrating. The per-payer tables retire after a soak.

- [ ] [**Decide** when the C8-family payers move](notes/c8-family-timing.md) (C8 1 + CDXP 3 decision h)
- [ ] [Migrate the first payer of each kind](notes/first-of-each-kind.md) (CDXP, 120 dev h)
- [ ] [Migrate the remaining payers](notes/remaining-payers.md) (CDXP, 36 dev h)
- [ ] [Re-point CDXP's own readers](notes/cdxp-readers.md) (CDXP, 40 dev h)
- [ ] [Push the consolidated (PA and shared data model) tables to HNA](notes/hna-push.md) (CDXP, 24 dev h)
- [ ] [Retire the per-payer tables after a soak](notes/retire-per-payer-tables.md) (CDXP, 24 dev h)

**Phase total:** C8 0 dev h, 1 decision h | CDXP 244 dev h, 3 decision h
