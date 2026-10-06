# Decide whether to converge on one engine

[Back to steps](../steps.md)

- **Why:** after the merge, two engines and two sets of restrictions remain: Collaborate's filters at staging, and CDXP's ingestor with its model checks.
- **Options:**
  - Keep both, each owning its own restrictions.
  - One rule engine for both Collaborate's filters and CDXP's model checks.
  - Move filtering into Snowflake (HNA Gold).
- **Rule:** pick exactly one owner per restriction, so nothing is built twice.
- **Builds on:** the ingestion restriction decisions in [phase 2](../../02-decide-and-design/steps.md).
