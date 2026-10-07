# Re-point CDXP's own readers

[Back to steps](../steps.md)

- PayerPath delta.
- IFGapStats: `spGetIFGapStatsForSite`, which joins every payer's gap table.
- Realtime gap requests: `spGetBulkGaps`.
- The status funnel: `spSaveGapStatus`, which has one branch per payer today.
- Member matching and cleanup.
- HNA sync registrations.
