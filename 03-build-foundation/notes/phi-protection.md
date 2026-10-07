# Apply the PHI protection

[Back to steps](../steps.md)

- Build whatever [the PHI decision](../../02-decide-and-design/notes/phi-model.md) picks.
- **Key access:**
  - Who can use the encryption key and the hash salt? These are the Key Vault secrets `DbEncryptionKeyPhrase` and `DbHashKey`.
  - May Collaborate's app decrypt?
- Access auditing on the shared tables.
- Least-privilege roles for the people who query the data, such as CTQ analysts and DBOps.
