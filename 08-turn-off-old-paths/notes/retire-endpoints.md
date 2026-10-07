# Retire the old endpoints and API keys

[Back to steps](../steps.md)

- Retire them once no customer uses them.
- **Collaborate:**
  - The `send/gap`, `send/gap/signoff/{otbId}`, and `send/gap/feedback` endpoints.
  - FHIR Publish: `FhirOutboundService`, `CreateFhirPublishBatches`, and `GetActiveGapsByNpis`.
- **CDXP:** the `C8BulkController` routes, `C8BulkHandler`, and `C8PublishDetail`.
- **API keys:** `C8APIKey`, `CDXPFhirPublishKey`, and the matching `APIKeySecret` and `InboundApiKeys` entries.
