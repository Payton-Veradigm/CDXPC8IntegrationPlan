# 2. Design the shared data model

[Back to the one-page plan](../one-page.md)

CDXP and Collaborate meet and design the shared data model, and settle the decisions it depends on.

## Already decided (2026-10-07)

- [x] [**Decide** where the shared tables live](notes/where-tables-live.md): CDXP's consolidated bulk tables, in `cdxp`
- [x] [**Decide** the shape of the shared tables](notes/table-shape.md): one shared data model, built into the consolidated bulk tables
- [x] [**Decide** whether to move data first or rebuild the pipeline first](notes/data-or-pipeline-first.md): CDXP's process takes in Collaborate's data, checked against TRX
- [x] [**Decide** who runs staging and filtering](notes/staging-owner.md): CDXP's process

## Direction

- [ ] [**Decide** how customers' data is kept apart](notes/tenant-isolation.md) (Both, 6 decision h each, with Compliance)
- [ ] [**Decide** the tenant key and partitioning](notes/tenant-key.md) (Both, 3 decision h each)
- [ ] [**Decide** how member PHI is protected](notes/phi-model.md) (Both, 6 decision h each, with Security)
- [ ] [**Decide** how the Portal and PFA will reach the data](notes/access-pattern.md) (Both, 4 decision h each)

## Data model

- [ ] [Agree the shared data model](notes/shared-data-model.md) (Both, 12 decision h each)
- [ ] [**Decide** how a gap is identified](notes/gap-identity.md) (Both, 4 decision h each)
- [ ] [**Decide** how a member is identified](notes/member-identity.md) (Both, 3 decision h each)
- [ ] [**Decide** the gap lifecycle and status rules](notes/lifecycle-and-status.md) (Both, 4 decision h each)
- [ ] [**Decide** what replaces FHIR Publish](notes/replace-fhir-publish.md) (Both, 6 decision h each)
- [ ] [**Decide** how gap types and lines of business map](notes/taxonomy-and-lob.md) (Both, 3 decision h each)
- [ ] [**Decide** which product owns each column](notes/column-ownership.md) (Both, 2 decision h each)
- [ ] [**Decide** the time zone basis](notes/time-basis.md) (Both, 2 decision h each)
- [ ] [**Decide** how CDXP's process gets the Portal data it needs](notes/portal-dependencies.md) (Both, 2 decision h each)
- [ ] [**Decide** what happens to TRX's other data](notes/other-trx-data.md) (C8, 2 decision h)

## Ingestion restrictions (Collaborate's filtering, CDXP's model filtering)

- [ ] [Map both products' ingestion restrictions side by side](notes/restrictions-today.md) (C8 6 + CDXP 6 dev h)
- [ ] [**Decide** which restrictions apply to which tenants and gaps](notes/restriction-scope.md) (Both, 4 decision h each)
- [ ] [**Decide** how each restriction runs in CDXP's process](notes/restriction-order.md) (Both, 4 decision h each)
- [ ] [**Decide** who configures restrictions, and where](notes/restriction-config.md) (Both, 3 decision h each)
- [ ] [**Decide** how a dropped gap is recorded and explained](notes/dropped-gap-log.md) (Both, 2 decision h each)
- [ ] [**Decide** where CTQ review happens in the new process](notes/ctq-review.md) (Both, 4 decision h each)

## Proofs

- [ ] [Run the proof-of-concept spikes](notes/spikes.md) (C8 8 + CDXP 48 dev h)

**Phase total:** C8 14 dev h, 76 decision h | CDXP 54 dev h, 74 decision h
