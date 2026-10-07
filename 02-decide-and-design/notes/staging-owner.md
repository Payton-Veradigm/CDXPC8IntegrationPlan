# Decide who runs staging and filtering

[Back to steps](../steps.md)

- **Decided (2026-10-07, per Payton Obrycki):** CDXP's process (the spec builder and ingestor) runs staging and filtering for Collaborate's data.
- **Options considered:**
  - A. Collaborate's existing engine, pointed at the shared tables.
  - B. CDXP's process, built on Payer Automation's configuration.
  - C. Snowflake (HNA Gold). Scott Ackerson took this position in the September sessions.
- **Next:**
  - [Which restrictions apply](restriction-scope.md).
  - [How they run](restriction-order.md).
  - [Where CTQ review happens](ctq-review.md).
