# Decide which product owns each column

[Back to steps](../steps.md)

- **Lean:** one owner per column, and only the owner's code writes to it.
  - **CDXP's process:** gap content and the in-source and expired states from ingestion, delivery status, member-to-patient matches, validation drops, and delivery back to payers.
  - **Collaborate's Portal and PFA:** feedback, documents, and admin configuration.
- **Also decide:** who owns the lifecycle changes that come from feedback, such as responded and closed.
- **How:** tag every column in the [data model](shared-data-model-sql.md) with its owner before anything is built.
- **Source:** Jason's proposal, step 3, adjusted so that CDXP's process does the ingestion.
