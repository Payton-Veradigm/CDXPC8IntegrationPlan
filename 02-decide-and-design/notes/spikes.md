# Run the proof-of-concept spikes

[Back to steps](../steps.md)

- Use fake or masked data only.
- **Who:** mostly CDXP, since it builds the model. Collaborate supplies the PFA's query patterns and checks the results.
- **PFA speed:** load the member grid, gap details, and KPIs for a large customer from shared, partitioned, filtered tables. Compare with the VM today.
- **Collaborate's filters in CDXP's process:** express one customer's filter rules in the ingestor, and compare the output with TRX staging.
- **Network:** connect from a Collaborate environment to CDXP's SQL with a managed identity.
- **CDC:** measure change capture and the Snowflake sync at full volume.
- **Filtered index:** create the one-live-gap index through CDXP's real pipeline in Boron and Cadmium. About 31 deployed `cdxp` tables can't hold filtered indexes because of a legacy setting.
- **Time zone:** compare TRX timestamps (local time) with the new UTC ones across a daylight-saving change.
- **Documents:** copy a sample of chart bytes to Blob Storage, and measure the speed against the database's log write cap (about 105 MiB/s in Cadmium).
