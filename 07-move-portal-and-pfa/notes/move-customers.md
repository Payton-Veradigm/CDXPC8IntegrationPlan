# Move the first customer, then the rest

[Back to steps](../steps.md)

- **Order:** the same as [the cut-in order](../../05-cut-in-and-verify/notes/cut-in-order.md). Only customers with signed-off parity move.
- **For each customer:**
  1. Copy its feedback and history.
  2. Flip its switches: the Portal and PFA, the point of care, and soft closure. FHIR Publish stops for the customer.
  3. Verify the screens and the point of care.
  4. Soak, per [the cutover decision](cutover-and-rollback.md).
- Re-point the customer's CTQ scripts as it moves.
- Its TRX database stays until phase 9, for rollback.
- **Estimate basis:** the first customer carries most of the hours. The rest follow the same runbook.
