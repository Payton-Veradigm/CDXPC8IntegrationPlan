# Decide who configures restrictions, and where

[Back to steps](../steps.md)

- **Today:**
  - **Collaborate:** admins edit filter rules, diagnosis filters, and LOB settings in admin screens, and payer users edit targeting lists. All of it is per customer.
  - **CDXP:** `GapModels` and `RestrictiveModels` live in the database, shared by all payers. The spec builder adds versioned specs per payer.
- **Decide:**
  - Where each kind of restriction is configured once the products merge.
  - Who can change it: admins, payer users, or the CDXP team.
  - Whether a change needs review before it takes effect.
- **Lean:** keep each product's configuration where it is for the merge. Move both onto one tenant-keyed screen later.
