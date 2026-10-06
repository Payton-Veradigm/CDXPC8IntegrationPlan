# Run old and new side by side

[Back to steps](../steps.md)

- Run both for every customer and LOB, for ANR and OTB data.
- Diff the output, and investigate every difference.
- **Make value-source lookup failures fail the run.** Today they only log a warning, so a broken rule can filter wrongly without anyone noticing.
