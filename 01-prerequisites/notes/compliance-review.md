# Start the compliance review

[Back to steps](../steps.md)

- **Why:** this is the longest-lead item. If compliance rejects shared tables, the design changes.
- **What changes:** today each customer has its own TRX database, "for compliance and data isolation". Isolation has four layers:
  - The Auth0 organization.
  - The role's customer ID.
  - The separate database.
  - A Power BI workspace per customer.

  Shared tables replace the database layer with controls inside one database.
- **Take to Security, Compliance, and Legal:**
  - Shared tables with row-level security (see [tenant isolation](../../02-decide-and-design/notes/tenant-isolation.md)).
  - The PHI model. TRX stores demographics in plain columns, while CDXP encrypts them.
  - Restoring, exporting, and deleting one customer's data.
  - Access auditing.
- **Open:**
  - Does any customer contract or BAA require separate databases?
  - Are TDE, backup encryption, and access auditing on for TRX today?
