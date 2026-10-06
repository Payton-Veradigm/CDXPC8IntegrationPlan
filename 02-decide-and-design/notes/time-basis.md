# Decide the time zone basis

[Back to steps](../steps.md)

- **Why:** TRX assumes the VM's local clock. Azure SQL is always UTC, and that can't be changed.
  - TRX SQL calls `GETDATE()` about 410 times, in 181 files.
  - Collaborate's core code uses `DateTime.Now` 153 times and `DateTime.UtcNow` 21 times.
  - CDXP's `GETDATE()` calls already return UTC.
- **Options:**
  - A. UTC everywhere. Convert the old timestamps during migration, and convert to one business time zone only where dates matter: program year, data month, reports, and publish windows.
  - B. Keep local time in Collaborate's tables, through a shared "business now" function.
- **Lean:** A.
- **First:** find out what time zone the TRX VMs use.
