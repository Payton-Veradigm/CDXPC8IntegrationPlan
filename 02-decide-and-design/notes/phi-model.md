# Decide how member PHI is protected

[Back to steps](../steps.md)

- **The conflict:**
  - TRX stores names, dates of birth, addresses, phone numbers, MRNs, and government IDs in plain columns.
  - CDXP encrypts member demographics with a SQL symmetric key, and looks members up by salted hashes.
  - The PFA searches, sorts, and displays members by name.
  - HNA sync decrypts member columns on their way into Snowflake.
- **Options:**
  - A. CDXP's model for everyone: decrypt inside procedures, and look members up by hash.
  - B. Always Encrypted. It allows equality lookups only; without secure enclaves, there's no server-side sorting or pattern search.
  - C. Plain columns, protected by TDE, row-level security, least privilege, masking, and auditing.
- **Lean:** none yet. Measure option A on PFA screens in a spike first, then decide with Security.
