# Prove Collaborate's filters give the same results on the shared tables

[Back to steps](../steps.md)

- Run the pilot customer's staging on TRX and on the shared tables, with the same input.
- Compare the filter outcomes rule by rule (`DetailStagingFilterLog`), and the gaps that result.
- **Watch value-source rules.** They look up tables by name, and those tables move.
- **Done when:** the outcomes match, or every difference is explained.
