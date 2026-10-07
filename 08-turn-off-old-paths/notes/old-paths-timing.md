# Decide when each customer's old paths turn off

[Back to steps](../steps.md)

- **What's left by now:** the old OTB and CORE heads and TRX's staging, which keep TRX current for rollback, plus the old endpoints. The point of care and soft closure already moved with the Portal and PFA.
- **Lean:**
  - Turn off a customer's old heads after its move has soaked and its rollback window has closed.
  - Retire the endpoints once no customer uses them.
- **Once a customer's old heads are off,** rolling back to TRX means turning them back on and catching TRX up.
- **Set by:** [the cutover decision](../../07-move-portal-and-pfa/notes/cutover-and-rollback.md).
