# Decide how a member is identified

[Back to steps](../steps.md)

- **Today:**
  - **TRX:** one member per member ID and LOB, with a GUID key (`AlertMemberId`).
  - **CDXP (C8 family):** a salted hash of member ID, date of birth, and first name. Correcting a birth date or a first name creates a new member.
- **Lean:**
  - One member per tenant, LOB, and payer member ID.
  - Keep `AlertMemberId` during the transition.
  - CDXP's hashes become match attributes, not identity.
- **Coordinate with:** CIEP #168077, the v2 hash backfill across the payer member tables (New).
- **Open:**
  - Which member ID is canonical when a customer displays a different insurance-card ID?
  - Who owns the deceased flag?
