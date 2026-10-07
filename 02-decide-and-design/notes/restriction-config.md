# Decide who configures restrictions, and where

[Back to steps](../steps.md)

- **Today:**
  - **Collaborate:** admins edit filter rules, diagnosis filters, and LOB settings in admin screens, and payer users edit targeting lists. All of it is per customer.
  - **CDXP:** `GapModels` and `RestrictiveModels` live in the database, shared by all payers. The spec builder adds versioned specs per payer.
- **Decide:**
  - Where each kind of restriction is configured once the products merge.
  - Who can change it: admins, payer users, or the CDXP team.
  - Whether a change needs review before it takes effect.
- **Lean:**
  - Collaborate's settings move into `cdxp`, keyed by tenant, because CDXP's process reads them.
  - Until the Portal's admin screens move (phase 7), copy changes over from TRX, so both sides filter with the same rules.
  - CDXP's model settings stay where they are. Put both on one tenant-keyed screen later.
