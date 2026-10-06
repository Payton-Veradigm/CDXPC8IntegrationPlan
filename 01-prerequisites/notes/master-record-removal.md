# Collaborate team: remove the master record

[Back to steps](../steps.md)

- **What it is:** the Collaborate team's own project, led by Jason Kallelis. It stops writing `alert.Master` and makes TRX gap-centric. The branch is `jk/pfa-refactor`.
- **Why this plan depends on it:**
  - The data we migrate should already be gap-centric.
  - Its gap-centric tables are one input to the shared data model, which the teams plan together and build in `cdxp`.
- **Not a dependency:** the broader PFA rewrite, which may not happen.
- **Deadline:** BCBSMI needs several concurrent quality periods in early 2027 (per Jason's proposal).
- **Status (2026-09-29):** 18 commits ahead of `main` and 6 behind, with about 143 files changed in the TRX schema.
- **Key changes:**
  - One live gap per member, detail code, detail type, and program year.
  - New lifecycle columns: `IsInSource`, `IsExpired`, `ProgramYear`, `EvaluationPeriod`, and `GapSource`.
  - Status is derived, not stored (`alert.vw_GapStatus`).
  - New tables: `FeedbackHistory`, `MemberProviderStatus`, and `MemberMonths`.
  - `AlertType` becomes `InsightType`. `alert.Master` stays, but only as a history pointer.
- **Not in code yet:** the PCP-based FHIR Publish.
- **Hours:** the Collaborate team's own estimate. They aren't counted in this plan.
