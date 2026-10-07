# Make the nightly jobs work against the new source

[Back to steps](../steps.md)

- **Re-point for moved customers:** RunAllProviderAlertReports, PullCharts, BuildCompletedAlertCodingComparison, RebuildRoster, and ReferenceTableSync.
- **Stop at the move,** per [the cutover decision](cutover-and-rollback.md): ProviderAlertProcessing's publish, and FhirPublishDryRun.
- **Keep running against TRX until the old heads turn off (phase 8),** so TRX stays current for rollback: ProviderAlertProcessing's staging, and ClearQueueTables.
- All of these are removed in phase 9, since CDXP's process does the work.
- Each job runs per tenant against one database. Watch locking and run times.
