# Set TRX databases read-only, archive them, then drop them

[Back to steps](../steps.md)

- Set each database read-only after its customer's soak.
- Archive it per the retention decision, then drop it.
- Remove its entry from `db/DatabaseConfig.json`, and its publish profile.
