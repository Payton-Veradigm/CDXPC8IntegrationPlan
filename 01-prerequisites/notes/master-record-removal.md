# Finish the master-record removal on `jk/pfa-refactor`

[Back to steps](../steps.md)

- **What:** Jason Kallelis's refactor that makes Collaborate gap-centric. Today a master record (`alert.Master`) is one alert case per member, provider, type, and period, and its gaps hang off it. After the refactor, gaps, members, and PCPs carry that state themselves.
- **Why it's a prerequisite:**
  - The shared data model is built from this branch's columns and its live-gap rule.
  - TRX has to be gap-centric before the side-by-side checks (phase 5), so both sides compare gap to gap.
  - The PFA has to be gap-centric before it moves to the new source (phase 7).
- **Status (branch tip `9996ae801`, 2026-10-01):**
  - 24 commits and 470 files changed against `main`, with `feature/pfa-refactor` folded in.
  - The commits so far cover:
    - the gap lifecycle schema and the live-gap index;
    - staging and the intake queue keyed on gap identity;
    - provider access through the member's PCP;
    - gap status and member rollups;
    - provider screens, feedback, and documents;
    - FHIR Publish by member and PCP;
    - reports and Snowflake feeds.
  - References to `alert.Master` are down from about 1,856 (273 files) on `main` to about 1,070 (195 files).
- **What's left (estimate basis, 72 h):**
  - About 150 references in the app (Core, Models, Context, and Web.Portal) and the PFA's views: 32 h.
  - 15 in the report procedures and 3 in the Snowflake views: 8 h.
  - 264 in the tests: 16 h.
  - Merging with `main` (the branch is 24 commits behind), review, and a full PFA and admin regression pass: 16 h.
- **Left alone on purpose:**
  - The old pre- and post-deployment scripts (327 references), which are history.
  - Most of the alert schema's 312 references are in the staging and publish procedures, such as `PostPublishState`, `UpdateStagingLogs`, and `PublishAlerts`. CDXP's process replaces them in phase 5, and they're deleted in phase 9.
- **Owner:** Jason Kallelis.
- **Update (2026-10-30):** the work is now on the shared branch `feature/pfa-refactor` (Feature 170585), open for shared development through PRs. What it changes in the C8 data model: [pfa-refactor-data-model.md](../../02-decide-and-design/notes/pfa-refactor-data-model.md).
- **Open:**
  - Does anything still need to read `alert.Master` once the PFA is gap-centric? If staging and publish only write it, leave them as they are.
  - The [shared data model draft](../../02-decide-and-design/notes/shared-data-model-sql.md) was built from `c6e9e3bf8` (2026-09-29). The branch has since renamed GapType to InsightType, and moved documents and feedback onto the member and gap. Refresh the draft before phase 2's model sessions.
