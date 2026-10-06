# Decide the tenant key and partitioning

[Back to steps](../steps.md)

- **Options for the key:**
  - A. Extend `cdxp.Payer` and use its key, adding a payer row for each Collaborate-only customer.
  - B. Use Collaborate's customer ID.
  - C. A new tenant registry that both products reference.
- **Lean:** A, if CIEP's `PayerPartitionKey` design allows it. Either way, one key space.
- **Also decide:**
  - **Partitions:** one per tenant, created before the tenant arrives. This is CIEP's pattern.
  - **Which axis per table:** gaps, members, feedback, documents, and staging would partition by tenant. CDXP's member-to-patient matching tables would stay partitioned by site. A table can use only one scheme.
  - **LOB:** stays a column, and is not part of the partition.
