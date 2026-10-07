# Decide how environments pair up, and the test data rules

[Back to steps](../steps.md)

- **Collaborate:** Dev, QA, Stage (a copy of production data), and Prod.
- **CDXP:** Boron (dev), Cadmium (stage), and PROD. Whether a QA environment still exists is unconfirmed.
- **CDX Snowflake:** has no Stage environment (per Jason's proposal).
- **Lean:** pair by tier: Dev with Boron, Stage with Cadmium, and Prod with PROD. Then agree where Collaborate's QA points.
- **Open:**
  - Does Cadmium allow production PHI? Pairing it with Collaborate's Stage would put a copy of production data there.
  - Does CDXP still have a QA environment?
- **Also agree:** the rules for synthetic test data.
