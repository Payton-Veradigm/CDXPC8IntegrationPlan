# List everything that reads or writes the data

[Back to steps](../steps.md)

- **Why:** anything we miss breaks at cutover.
- **Collaborate side (known):**
  - The PFA and admin screens.
  - Hangfire jobs that loop over customers: ProviderAlertProcessing, RunAllProviderAlertReports, PullCharts, BuildCompletedAlertCodingComparison, FhirPublishDryRun, ClearQueueTables, RebuildRoster, and ReferenceTableSync.
  - CTQ SQL scripts and the OTB queue validation query, which people run in SSMS.
  - The seven `snowflake` views read by UDP, including finance counts and the provider feedback used for risk adjustment.
  - Power BI (one workspace per customer) and the Care Gap Utilization Dashboard.
- **CDXP side (known):**
  - Per-payer orchestrators, `C8BulkController`, OTB, and Centene send.
  - PayerPath delta, IFGapStats, and realtime gap requests.
  - `spSaveGapStatus`, matching, and cleanup.
  - HNA sync and `rpt` reporting.
- **Open:** what reads TRX from outside the repos? Candidates include the UDP pipelines (possibly running on the availability group's node 3), finance, and Power BI sources.
