# Decide which Collaborate customers are cut in, and how much history moves

[Back to steps](../steps.md)

- **What we know:** 20 customer TRX databases are configured, but the Customer Overview lists only 9 configured customers.
- **Lean:** cut in live customers only, and archive the dormant databases instead.
- **History:** for example, the current and prior program years of gaps, feedback, members, and documents. Older history stays in the archived backups.
- **Ties to** [how long TRX backups are kept](../../09-retire/notes/trx-retention.md). History that doesn't move lives only in those backups.
- **Note:** CDXP's gap content blobs older than 90 days may already be gone.
