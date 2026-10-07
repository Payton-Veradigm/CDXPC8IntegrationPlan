# Work with RAA to feed ANR data into CDXP's process

[Back to steps](../steps.md)

- **What:** the ANR risk and quality data that Collaborate stages from Snowflake today (`CLIENT_ANR_LEGACY_ALERTS`). RAA is the team behind it.
- **Ask RAA:**
  - How CDXP's ingestor should read the data.
  - How often it arrives.
  - How a finished run is marked.
- **Map it** through the spec builder, like any other feed.
- **Keep TRX fed** as it is today, during the side-by-side run.
- **Watch:** ANR staging today waits for a UDP schema swap before it starts. The new feed needs the same signal.
