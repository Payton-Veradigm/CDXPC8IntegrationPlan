# Build the side-by-side comparison with TRX

[Back to steps](../steps.md)

- **Compare, per payer and per run:**
  - Members, providers, and gaps: identity, whether they're in source, and whether they've expired.
  - Filter outcomes, rule by rule: TRX's `alert.DetailStagingFilterLog` against the new process's drop log.
  - What each audience sees: the PFA and the point of care.
- **Normalize first.** TRX times are local and the new tables are UTC. Check that the collations match.
- **Report:** row counts, checksums, and a list of every difference, with the rule or field behind it.
- **Reuse** CIEP's parallel-run comparison and scratch partitions (#170106). Keep scratch rows out of Snowflake.
- **Needs:** a network path between the TRX VMs and CDXP's SQL.
