# Re-point the CTQ and OTB scripts

[Back to steps](../steps.md)

- **Today:**
  - CTQ analysts run red-flag, change-reason, and quality-measure SQL from a file share, against the customer's database, in SSMS over VPN.
  - OTB validation runs the `OTB_and_Queue_Validation` query.
- Rewrite the scripts that are still needed for the shared tables, scoped to one tenant.
- **Depends on:** [where CTQ review happens](../../02-decide-and-design/notes/ctq-review.md). Any review queries already [built into CDXP's process](../../05-cut-in-and-verify/notes/ctq-in-cdxp.md) don't need re-pointing here.
- **Open:** where will analysts get SQL access in the target, and with what permissions?
