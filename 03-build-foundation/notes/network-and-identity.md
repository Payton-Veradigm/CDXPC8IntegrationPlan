# Connect Collaborate's environments to CDXP's SQL

[Back to steps](../steps.md)

- **The products run in different Azure subscriptions:**
  - Collaborate: Mendelevium (dev), Darmstadtium (QA), Roentgenium (stage), and Copernicium (prod).
  - CDXP: Boron, Cadmium, and PROD.
- Set up private connectivity from each Collaborate environment to its paired CDXP SQL.
- **Identity:** use managed identities instead of API keys. Today's keys (`C8APIKey`, `CDXPFhirPublishKey`, and the matching `APIKeySecret` and `InboundApiKeys` entries) retire with the round trips.
- **Open:** can Collaborate's Azure workloads reach CDXP's SQL privately today?
