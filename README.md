# CDXP + Collaborate integration plan

A working plan for moving Collaborate's per-customer TRX databases and CDXP's per-payer bulk tables into one set of shared, tenant-partitioned tables in CDXP's Azure SQL database.

**The approach (agreed 2026-10-07):**

1. The CDXP team builds its spec builder, ingestor, and consolidated bulk tables, as its own project.
2. CDXP and Collaborate design one shared data model together.
3. CDXP implements the model in the consolidated bulk tables, in CDXP's codebase.
4. Collaborate's payers are cut into CDXP's process one at a time, and checked side by side against TRX until the data matches. This includes making OTB multi-headed and working with RAA on the ANR data.
5. Once a payer's data matches, Collaborate moves the Portal and PFA to the new source. The point of care and soft closure move at the same time.

Collaborate takes part in every decision. CDXP does most of the building.

## How it's organized

There are three levels, each more detailed than the last:

1. **[one-page.md](one-page.md)** is the whole plan on one printed page. Each numbered item is a phase, with its estimates per team and a link to its folder.
2. **`<phase>/steps.md`** is a checklist for that phase. Each line is one thing that has to happen, or one decision that has to be made.
3. **`<phase>/notes/*.md`** has one file per step, with bullet-point notes: why it matters, what we know, the options, and the open questions.

```text
CDXPC8IntegrationPlan/
  README.md
  one-page.md
  01-prerequisites/
    steps.md
    notes/
      baseline-trx.md
      ...
  02-decide-and-design/
  03-build-foundation/
  ...
  09-retire/
```

## Reading a steps.md

- `- [ ]` is open and `- [x]` is done. Tick the boxes as you go.
- Lines that start with **Decide** are decisions. Every other line is work.
- Phase 2 starts with decisions that are already made. They're ticked, and each notes file records the decision.
- The end of each line says who owns it and how long it should take:
  - `(C8, 16 dev h)`: one team owns it.
  - `(C8 16 + CDXP 24 dev h)`: both teams, with different amounts.
  - `(Both, 6 decision h each)`: both teams, with the same amount each.
  - `(Merged, 16 dev h)`: the combined team, assumed from phase 8 on.
  - `with DBOps`: another group is needed too. It can also be DevOps, Security, Compliance, RAA, or Team Banyan.
- C8 is the Collaborate team.
- Each `steps.md` ends with a phase total.

## Estimates

- **Dev hours** are hands-on work: building, porting, testing, and tooling. They assume LLM-assisted development.
- **Decision hours** are analysis, meetings, write-ups, and sign-off. LLM assistance doesn't shrink these.
- Both are people-hours for the C8 and CDXP teams. Time from other groups isn't counted.
- Hours measure effort, not calendar time. Sign-offs, side-by-side cycles, and soaks add calendar time on top.
- About 40 hours is one person-week.
- The CDXP team's spec builder, ingestor, and consolidated tables are its own project. This plan depends on them but doesn't count their hours.
- All the numbers are starting guesses. Replace them as each team sizes its work, and keep the phase totals and `one-page.md` in sync.

## Editing rules

- Keep `one-page.md` to one printed page. If it grows, push the detail down a level.
- One step per line in `steps.md`. Anything that needs explaining goes in the step's notes file.
- Notes are bullets, not prose.
- When a decision is made, record it in its notes file under **Decided**: what was decided, when, and by whom.
- To add a step:
  - Add its line to `steps.md`, with an owner and an estimate.
  - Create its notes file from the template below.
  - Update the phase total.
- Keep PHI, secrets, and connection strings out of this repo.

## Notes template

```markdown
# Step title

[Back to steps](../steps.md)

- **Why:** ...
- **Options:** (decisions only)
- **Lean:** (decisions only)
- **Decided:** (when settled: what, when, who)
- **Open:** ...
```

## Background

- The plan grew out of Jason Kallelis's shared gap repository proposal (2026-09-29).
- Its facts were checked against both code repos, both knowledge bases, and Azure DevOps (Collabor8 and CIEP) between 2026-09-30 and 2026-10-02.
- Work item numbers (for example #169995) are Azure DevOps IDs in CIEP or Collabor8.
- RAA is the team behind the ANR risk and quality data that Collaborate stages from Snowflake today.
