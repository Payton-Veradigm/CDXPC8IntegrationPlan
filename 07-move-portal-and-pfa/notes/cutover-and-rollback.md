# Decide how cutover and rollback work

[Back to steps](../steps.md)

- **Decided (2026-10-07, per Payton Obrycki):** a customer moves all at once. The Portal, PFA, point of care, and soft closure switch to the new source together, and FHIR Publish stops for that customer.
- **Lean:** move each customer offline, inside the existing publish window. The PFA is already unavailable during publish.
- **During the soak:** the old OTB and CORE heads and TRX's staging keep feeding TRX, so it stays current for rollback.
- **To roll back:**
  1. Flip the customer's switches back to TRX.
  2. Turn FHIR Publish back on.
  3. Copy any feedback written since the move back to TRX.
- Rehearse the rollback before the first real customer moves.
- **Still to decide:** how long the soak lasts, and who can call a rollback.
