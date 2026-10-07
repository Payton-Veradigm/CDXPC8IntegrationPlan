# Decide how to keep workloads from slowing each other down

[Back to steps](../steps.md)

- **The concern:** PFA screens, ingest bursts, change capture, and reporting would all share one database (Hyperscale serverless, up to 40 vCores).
- **Options:**
  - Read replicas for PFA reads and reporting.
  - Compatibility level 160, which handles very different tenant sizes better.
  - A higher vCore ceiling.
- **Facts:**
  - Tenants range from about 2,300 gaps to 1.7 million.
  - Cadmium caps log writes at about 105 MiB/s.
- **Also decide:** how the cost is split between the products.
- **Decide after:** the PFA speed spike.
