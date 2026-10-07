# Decide how cutover and rollback work

[Back to steps](../steps.md)

- **Lean:** cut each customer over offline, inside the existing publish window. The PFA is already unavailable during publish.
- Keep the TRX database read-only during the soak, so it's there for rollback.
- Use live dual-writes only if a customer is too big for the window.
- Rehearse the rollback before the first real customer moves.
