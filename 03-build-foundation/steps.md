# 3. Build the shared foundation in CDXP

[Back to the one-page plan](../one-page.md)

CDXP builds the shared model in its codebase: the consolidated tables extended for Collaborate, isolation, PHI protection, and migration tooling, all tested with fake tenants. Collaborate reviews the work and takes part in the decisions.

- [ ] [Add Collaborate customers to the tenant registry](notes/tenant-registry.md) (CDXP, 8 dev h)
- [ ] [Extend the consolidated tables for Collaborate](notes/extend-consolidated-tables.md) (C8 4 + CDXP 52 dev h)
- [ ] [Build tenant isolation and prove it](notes/isolation.md) (CDXP, 36 dev h)
- [ ] [Apply the PHI protection](notes/phi-protection.md) (CDXP, 24 dev h, with Security)
- [ ] [Build the access contract](notes/access-contract.md) (C8 4 + CDXP 28 dev h)
- [ ] [Replace TRX's reads of the Portal database](notes/portal-replacement.md) (C8 8 + CDXP 24 dev h)
- [ ] [**Decide** how environments pair up, and the test data rules](notes/environment-pairing.md) (Both, 6 decision h each, with DevOps)
- [ ] [Connect Collaborate's environments to CDXP's SQL](notes/network-and-identity.md) (C8 8 + CDXP 8 dev h, with DevOps)
- [ ] [**Decide** what the shared tables send to Snowflake](notes/snowflake-policy.md) (Both, 4 decision h each, with Security)
- [ ] [**Decide** how to keep workloads from slowing each other down](notes/capacity.md) (C8 2 + CDXP 4 decision h, with DBOps)
- [ ] [**Decide** recovery targets and per-customer restore and deletion](notes/recovery-and-deletion.md) (Both, 4 decision h each, with Compliance)
- [ ] [Build the migration, reconciliation, and per-customer restore tooling](notes/migration-tooling.md) (C8 8 + CDXP 72 dev h)
- [ ] [Add per-tenant monitoring](notes/monitoring.md) (CDXP, 12 dev h)

**Phase total:** C8 32 dev h, 16 decision h | CDXP 264 dev h, 18 decision h
