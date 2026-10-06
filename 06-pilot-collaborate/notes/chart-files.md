# Decide where chart files live

[Back to steps](../steps.md)

- **Today:** chart files are stored as bytes inside TRX (`alert.Document`). The weekly chart pull reads them and writes them to folders set per customer.
- **Options:**
  - A. Move the bytes to Azure Blob Storage during migration, keeping a reference row in the database. This was the September sessions' preference.
  - B. Copy the bytes into `cdxp` as they are. That means more database storage and a slower migration.
- **Lean:** A.
- **Also decide:**
  - How documents are tagged to gap IDs.
  - Routing by LOB and insight type.
  - Retention.
  - Whether charts from eChart Courier chase requests use the same store.
