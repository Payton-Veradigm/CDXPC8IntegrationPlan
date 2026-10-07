# Migrate the first payer of each kind

[Back to steps](../steps.md)

- IHC, Xanthus, and Inovalon go first, and carry the learning cost for their kind.
- **For each one:**
  1. Author the payer's map.
  2. Run a recent file through the old path and the new one, and reconcile the results.
  3. Copy the history.
  4. Cut over, and verify.
- The history copy keeps statuses, patient matches, and PayerPath state (#170105).
- The parallel run writes into a scratch partition, followed by a one-step cutover switch (#170106).
- **Keep scratch rows out of Snowflake.** The sync mirrors every change, with no row filter.
