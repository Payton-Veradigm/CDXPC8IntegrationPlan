# Add a per-customer switch where Collaborate connects

[Back to steps](../steps.md)

- **Today:** one place picks a customer's database: `ConnectionRepository`. The customer's row names a connection setting, and its value comes from Key Vault.
- **Add** a per-customer setting: TRX or shared tables.
- **For shared tables:** set the tenant on the session (for row-level security) and in the EF Core query filters.
- **Result:** customers can move one at a time, and a customer rolls back by flipping the setting.
