# Confirm the master-record removal is in Prod

[Back to steps](../steps.md)

- The pilot moves gap-centric data, so the master-record removal has to be live first.
- **Check:**
  - The live-gap index is in place.
  - The lifecycle columns are populated.
  - `alert.Master` is no longer written to.
- **Background:** [Remove the master record](../../01-prerequisites/notes/master-record-removal.md).
