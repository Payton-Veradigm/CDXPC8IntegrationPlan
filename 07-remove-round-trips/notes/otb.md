# Move OTB intake to the shared tables

[Back to steps](../steps.md)

- CDXP keeps validating the payers' flat files.
- Instead of posting to Collaborate (`api/Fhir/send/gap`, then `send/gap/signoff/{otbId}`), CDXP writes the rows to shared intake tables.
- Collaborate's staging and CTQ review run as they do today, reading those tables.
- Published gaps are already in the shared tables, so nothing comes back over FHIR.
