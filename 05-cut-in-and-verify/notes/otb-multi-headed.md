# Make OTB multi-headed

[Back to steps](../steps.md)

- **Today:** CDXP validates a payer's OTB file and posts it to Collaborate's intake (`api/Fhir/send/gap`, then `send/gap/signoff/{otbId}`). TRX gets the gaps, and nothing else does.
- **Multi-headed:** each validated file goes two ways.
  - **Old head:** to Collaborate's intake, as today, so TRX stays current.
  - **New head:** into the shared tables, through CDXP's process.
- Turn the new head on for each payer as it's cut in.
- The old head turns off when that customer's old paths do (phase 8).
