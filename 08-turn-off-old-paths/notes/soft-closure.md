# Move soft-closure feedback to a direct write

[Back to steps](../steps.md)

- **Today:** CDXP posts EHR feedback to Collaborate (`send/gap/feedback`). Collaborate looks up a numeric gap ID as an internal ID first, so feedback can land on the wrong gap.
- **Proposal:** CDXP writes external feedback through a procedure keyed on the platform gap ID.
- **Keep Collaborate's rules:** no external feedback if the gap already has feedback, or if the alert is complete.
- **Keep** BCBSMI's direct CSV deliveries over SFTP.
- **Open:** which BCBSMI feedback endpoints (SFTP, API, or both) are on in Prod?
