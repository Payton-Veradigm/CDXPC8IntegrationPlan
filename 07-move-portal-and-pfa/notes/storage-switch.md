# Add a per-customer switch where the Portal and PFA connect

[Back to steps](../steps.md)

- **Today:** one place picks a customer's database: `ConnectionRepository`. The customer's row names a connection setting, and its value comes from Key Vault.
- **Add** a per-customer setting: TRX or the new source.
- **For the new source:** set the tenant on the session (for row-level security) and in the EF Core query filters.
- **Result:** customers move one at a time, and a customer rolls back by flipping the setting.
