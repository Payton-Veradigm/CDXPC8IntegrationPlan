# Decide testing standards and the definition of done

[Back to steps](../steps.md)

- **Today:**
  - Collaborate: integration tests against TRX, and Playwright end-to-end tests.
  - CDXP: a test automation suite, plus simulators for payers, VPI, and SFTP.
- **Agree:**
  - Contract tests for everything that crosses ownership.
  - Isolation tests in both pipelines, proving one tenant can't see another.
  - What "done" means for a change to the shared tables: tests, review, a migration script, and a rollback.
