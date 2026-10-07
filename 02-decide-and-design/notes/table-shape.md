# Decide the shape of the shared tables

[Back to steps](../steps.md)

- **Decided (2026-10-07, per Payton Obrycki):** both teams design one shared data model, and CDXP builds it into the consolidated bulk tables.
- **Options considered:**
  - A. CIEP's `BulkPayer*` tables as they are, with Collaborate adding its own columns.
  - B. A shared core (member, gap identity, content, lifecycle) plus extension tables that each product owns, built into CIEP's tables.
  - C. Co-locate first: move TRX's tables into `cdxp` nearly as they are, and converge them later.
- **Still open inside the model:** which columns are shared core and which are product extensions. See [the data model](shared-data-model.md).
