# Decide the release rules for shared tables

[Back to steps](../steps.md)

- **Proposed rules:**
  - **Additive changes only.** Rebuilding a CDC-tracked table drops its change capture, and that applies to Collaborate's tables too.
  - **Batched deletes.** `TRUNCATE` is refused on CDC-tracked tables.
  - **Shared process:** a joint release calendar, shared test environments, and joint on-call.
  - **Tenant-keyed data fixes.** Customer-specific fixes become scripts keyed on the tenant, not scripts that check the database name.
  - **Leave TRX's post-deployment chain behind.** Archive the 119 cumulative scripts rather than porting them.
- **Today:** Collaborate ships weekly (Wednesday evenings), and CDXP ships numbered releases.
