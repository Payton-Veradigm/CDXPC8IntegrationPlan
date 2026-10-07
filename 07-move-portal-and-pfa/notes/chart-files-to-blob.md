# Move chart files to Blob Storage

[Back to steps](../steps.md)

- Copy each customer's chart bytes from `alert.Document` to Blob Storage before it moves, keeping a reference row.
- Point the weekly chart pull and the PFA's document screens at Blob Storage.
- Keep the per-customer routing (`DocumentConfig`).
- **Depends on:** [the chart files decision](chart-files.md).
