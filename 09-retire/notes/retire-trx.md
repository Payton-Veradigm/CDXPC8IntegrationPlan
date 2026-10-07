# Set TRX databases read-only, archive them, then drop them

[Back to steps](../steps.md)

- Set each database read-only once its customer's old paths are off.
- Archive it per the retention decision, then drop it.
- Remove its entry from `db/DatabaseConfig.json`, and its publish profile.
