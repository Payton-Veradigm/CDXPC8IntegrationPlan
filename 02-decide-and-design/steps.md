# 2. Decide and design

[Back to the one-page plan](../one-page.md)

Both teams meet and design the shared data model, and make the big decisions, including ingestion restrictions.

## Direction

- [ ] [**Decide** where the shared tables live](notes/where-tables-live.md) (Both, 2 decision h each)
- [ ] [**Decide** the shape of the shared tables](notes/table-shape.md) (Both, 8 decision h each)
- [ ] [**Decide** how customers' data is kept apart](notes/tenant-isolation.md) (Both, 6 decision h each, with Compliance)
- [ ] [**Decide** the tenant key and partitioning](notes/tenant-key.md) (Both, 3 decision h each)
- [ ] [**Decide** whether to move data first or rebuild the pipeline first](notes/data-or-pipeline-first.md) (Both, 4 decision h each)
- [ ] [**Decide** how each product reaches the data](notes/access-pattern.md) (Both, 4 decision h each)
- [ ] [**Decide** how member PHI is protected](notes/phi-model.md) (Both, 6 decision h each, with Security)

## Ingestion restrictions (Collaborate's filtering, CDXP's model filtering)

- [ ] [Map both products' ingestion restrictions side by side](notes/restrictions-today.md) (C8 6 + CDXP 6 dev h)
- [ ] [**Decide** which restrictions apply to which tenants and gaps](notes/restriction-scope.md) (Both, 4 decision h each)
- [ ] [**Decide** where each restriction runs in the merged flow](notes/restriction-order.md) (Both, 4 decision h each)
- [ ] [**Decide** who configures restrictions, and where](notes/restriction-config.md) (Both, 3 decision h each)
- [ ] [**Decide** how a dropped gap is recorded and explained](notes/dropped-gap-log.md) (Both, 2 decision h each)
- [ ] [**Decide** who runs staging and filtering during the merge](notes/staging-owner.md) (Both, 3 decision h each)

## Data model

- [ ] [Agree the shared data model](notes/shared-data-model.md) (Both, 12 decision h each)
- [ ] [**Decide** how a gap is identified](notes/gap-identity.md) (Both, 4 decision h each)
- [ ] [**Decide** how a member is identified](notes/member-identity.md) (Both, 3 decision h each)
- [ ] [**Decide** the gap lifecycle and status rules](notes/lifecycle-and-status.md) (Both, 4 decision h each)
- [ ] [**Decide** how gap types and lines of business map](notes/taxonomy-and-lob.md) (Both, 3 decision h each)
- [ ] [**Decide** which product owns each column](notes/column-ownership.md) (Both, 2 decision h each)
- [ ] [**Decide** the time zone basis](notes/time-basis.md) (Both, 2 decision h each)
- [ ] [**Decide** what happens to TRX's reads of the Portal database](notes/portal-dependencies.md) (C8, 3 decision h)
- [ ] [**Decide** what happens to TRX's other data](notes/other-trx-data.md) (C8, 2 decision h)

## Proofs

- [ ] [Run the proof-of-concept spikes](notes/spikes.md) (C8 8 + CDXP 48 dev h)

**Phase total:** C8 14 dev h, 84 decision h | CDXP 54 dev h, 79 decision h
