# Turn off the old OTB and Centene CORE heads

[Back to steps](../steps.md)

- Stop posting the customer's OTB files to Collaborate's intake (`send/gap`, `send/gap/signoff/{otbId}`). The new head keeps writing to the shared tables.
- Do the same for Centene CORE.
- Stop TRX's staging for the customer at the same time. TRX then stops changing, and is ready to retire (phase 9).
