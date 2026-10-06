# Check with Team Banyan

[Back to steps](../steps.md)

- **Why:** Team Banyan is building the UDP replacement (in development). It streams changes into Snowflake `BRONZE_*` tables.
- **Ask:** does it read TRX? If so, it will need to read the shared tables once TRX moves.
- **Also changing:** during customer onboarding today, UDP adds each new TRX database to its pipelines.
- **Risk:** anything they build against TRX now gets partly redone.
