# 7. Remove the round trips

[Back to the one-page plan](../one-page.md)

For customers both products serve, OTB, Centene CORE, FHIR Publish, and soft closure stop moving gaps between the products.

- [ ] [**Decide** what replaces FHIR Publish](notes/replace-fhir-publish.md) (Both, 6 decision h each)
- [ ] [**Decide** how OTB and Centene CORE reach the shared tables](notes/otb-and-core-path.md) (C8 2 + CDXP 3 decision h)
- [ ] [Move OTB intake to the shared tables](notes/otb.md) (C8 24 + CDXP 40 dev h)
- [ ] [Move Centene CORE to the shared tables](notes/centene-core.md) (C8 8 + CDXP 24 dev h)
- [ ] [Replace FHIR Publish with a "visible to point of care" flag](notes/visible-flag.md) (C8 24 + CDXP 48 dev h)
- [ ] [Keep CDXP's model checks when FHIR Publish goes away](notes/model-checks.md) (C8 4 + CDXP 24 dev h)
- [ ] [Move soft-closure feedback to a direct write](notes/soft-closure.md) (C8 8 + CDXP 16 dev h)
- [ ] [Retire the old endpoints and API keys](notes/retire-endpoints.md) (C8 8 + CDXP 8 dev h)

**Phase total:** C8 76 dev h, 8 decision h | CDXP 160 dev h, 9 decision h
