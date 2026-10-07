# Make the nightly jobs work per customer in one database

[Back to steps](../steps.md)

- **Today:** these Hangfire jobs open each customer's TRX database in turn:
  - ProviderAlertProcessing.
  - RunAllProviderAlertReports.
  - PullCharts.
  - BuildCompletedAlertCodingComparison.
  - FhirPublishDryRun.
  - ClearQueueTables.
  - RebuildRoster.
  - ReferenceTableSync.
- In one database they become per-tenant loops. Watch locking and run times.
- `ClearQueueTables` clears every customer's queues in one run. Scope it to one tenant.
