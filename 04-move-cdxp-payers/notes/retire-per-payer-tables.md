# Retire the per-payer tables after a soak

[Back to steps](../steps.md)

- CIEP retires them in three groups:
  - The CSV payers (#170119).
  - The C8-family payers (#170120).
  - Inovalon (#170121).
- This retires 104 tables and 235 stored procedures in total.
- Humana's tables stay.
- Under the lean in [the C8-family decision](c8-family-timing.md), the C8-family group waits until the old paths are off, and goes with [CDXP's old code](../../09-retire/notes/cdxp-code.md).
