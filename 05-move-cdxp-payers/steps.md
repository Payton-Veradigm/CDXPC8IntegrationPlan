# 5. Move CDXP's bulk payers

[Back to the one-page plan](../one-page.md)

CDXP's existing bulk payers (all but Humana) moved onto the consolidated tables, and their per-payer tables retired. This is CIEP's Payer Migration plan (#170100).

- [ ] [**Decide** when the C8-family payers move](notes/c8-family-timing.md) (C8 1 + CDXP 3 decision h)
- [ ] [Migrate the first payer of each kind](notes/first-of-each-kind.md) (CDXP, 120 dev h)
- [ ] [Migrate the remaining payers](notes/remaining-payers.md) (CDXP, 36 dev h)
- [ ] [Re-point CDXP's own readers](notes/cdxp-readers.md) (CDXP, 40 dev h)
- [ ] [Retire the per-payer tables after a soak](notes/retire-per-payer-tables.md) (CDXP, 24 dev h)

**Phase total:** C8 0 dev h, 1 decision h | CDXP 220 dev h, 3 decision h
