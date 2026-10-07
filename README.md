# CDXP + Collaborate integration plan

A working plan for moving Collaborate's per-customer TRX databases and CDXP's per-payer bulk tables into one set of shared, tenant-partitioned tables in CDXP's Azure SQL database.

**The approach:**

- Both teams design the shared data model together.
- CDXP builds it, mostly in its own codebase and release flow.
- Collaborate then cuts over to it, one customer at a time.
- Collaborate stays involved in every decision.

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
  10-converge-filtering/
```

## Reading a steps.md

- `- [ ]` is open and `- [x]` is done. Tick the boxes as you go.
- Lines that start with **Decide** are decisions. Every other line is work.
- The end of each line says who owns it and how long it should take:
  - `(C8, 16 dev h)`: one team owns it.
  - `(C8 16 + CDXP 24 dev h)`: both teams, with different amounts.
  - `(Both, 6 decision h each)`: both teams, with the same amount each.
  - `(Merged, 16 dev h)`: the combined team, assumed from phase 8 on.
  - `with DBOps`: another group is needed too. It can also be DevOps, Security, Compliance, or Team Banyan.
- C8 is the Collaborate team.
- Each `steps.md` ends with a phase total.

## Estimates

- **Dev hours** are hands-on work: building, porting, testing, and tooling. They assume LLM-assisted development.
- **Decision hours** are analysis, meetings, write-ups, and sign-off. LLM assistance doesn't shrink these.
- Both are people-hours for the C8 and CDXP teams. Time from other groups isn't counted.
- Hours measure effort, not calendar time. Sign-offs, soaks, and monthly cycles add calendar time on top.
- About 40 hours is one person-week.
- Two prerequisites are each team's own project: the master-record removal (Collaborate), and the spec builder, ingestor, and consolidated tables (CDXP). This plan depends on them but doesn't count their hours.
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
