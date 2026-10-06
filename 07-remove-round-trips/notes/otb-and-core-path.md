# Decide how OTB and Centene CORE reach the shared tables

[Back to steps](../steps.md)

- **Today:** CDXP posts FHIR bundles to Collaborate's intake API. Collaborate stages them and publishes them back.
- **Lean:** CDXP writes validated rows straight into shared intake tables, and Collaborate's staging reads them there.
- **Needs:** a scope change in CIEP, whose Payer Migration plan (#170100) leaves OTB unchanged.
