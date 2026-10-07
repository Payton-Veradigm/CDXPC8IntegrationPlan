# Calendar timeline

[Back to the one-page plan](one-page.md)

**About 43 weeks with 3 devs per team, or about 46 weeks with 2, from the start of phase 1.** That's roughly 10 to 11 months.

- Most of the calendar is waiting, not work: design decisions, monthly side-by-side cycles, and soaks.
- A third dev on each team only shortens the build stretches (phase 3 and phase 5's build), so it saves about 3 weeks.
- Over the whole plan, this work fills about a third (3 devs) to half (2 devs) of CDXP's assumed time, and about a sixth to a fifth of Collaborate's.

## Assumptions

- **Capacity:** each dev gives about 30 hours a week to this plan. The rest goes to support, meetings, and other work. At full time (40 hours), the end moves to about 42 weeks (3 devs) or 44 (2 devs).
- **Hours:** the dev and decision hours in each `steps.md`, as they stand today.
- **Merged team:** both teams together, from phase 8.
- **Week 0** is the start of phase 1. The CDXP team's project (spec builder, ingestor, and consolidated tables) runs before or alongside phases 1 and 2, and has to be done by week 8. If it isn't, everything after week 8 moves out by the same amount.
- **Compliance** signs off on shared tables by week 8, before anything is built.
- **Waits,** taken from the notes, or assumed where the notes leave them open:
  - Phase 1: about 2 weeks to name owners, get DBOps's baseline, and start the compliance review.
  - Phase 2: about 6 weeks of weekly joint sessions for about 20 decisions, with Security and Compliance.
  - Phase 3: at least 3 weeks, for its decisions with DevOps, DBOps, Security, and Compliance.
  - First payer: two full monthly cycles side by side, Stage and then Prod.
  - Other payers: two waves of about 4. Each wave runs one monthly cycle, plus 2 weeks to work the differences down.
  - Each customer's soak after its move: 4 weeks. The length is still to decide.
  - Retirement: about 3 weeks for DBOps and Compliance.

## What overlaps

- **Phase 4** (CDXP's bulk payers) runs while phase 5's first payer is side by side. It's off the critical path, except re-pointing CDXP's readers, which has to be done before the first move.
- **Phase 6** runs alongside phase 5's build and first cycle, and finishes before the first move.
- **Phase 7's build** runs during phase 5: Collaborate from week 11, and CDXP once phase 5's build is done.
- **Phase 7's moves** follow each wave's parity sign-off, so moves and side-by-side runs overlap.
- **Phase 8** follows each customer's soak, so it overlaps the later moves.
- **Phase 9** starts once the last customer's old paths are off.

## Week by week

| Phase or stretch | 3 devs per team | 2 devs per team | Pace set by |
|---|---|---|---|
| 1. Prerequisites | Weeks 0 to 2 | Weeks 0 to 2 | Owners, DBOps, the compliance review |
| 2. Design the shared data model | 2 to 8 | 2 to 8 | Decisions |
| 3. Implement the shared data model | 8 to 11 | 8 to 11 | CDXP's work (206 h) |
| 5. Build the cut-in | 11 to 14 | 11 to 17 | CDXP's work (311 h) |
| 6. Agree how we build and release | 11 to 19 | 11 to 20 | Decisions |
| 7. Build for the Portal and PFA move | 11 to 23 | 11 to 26 | Work, alongside phase 5 |
| 5. First payer side by side | 14 to 23 | 17 to 26 | Two monthly cycles |
| 4. Move CDXP's bulk payers | 14 to 28 | 17 to 31 | CDXP's work, then a soak before the per-payer tables retire |
| 5. Other payers side by side | 23 to 35 | 26 to 38 | Two waves |
| 7. Moves and soaks | 23 to 40 | 26 to 43 | A 4-week soak after each move |
| 8. Turn off the old paths | 28 to 40 | 31 to 43 | Each customer's soak |
| 9. Retire the old pieces | 40 to 43 | 43 to 46 | DBOps and Compliance |

## Chart (3 devs per team)

```text
                          0    5    10   15   20   25   30   35   40   45
Week                      |    |    |    |    |    |    |    |    |    |
1 Prerequisites           ==
2 Design                    ======
3 Implement                       ###
5 Build the cut-in                   ###
6 Build and release                  ========
7 Build for the move                 ############
5 First payer, 2 cycles                 .........
4 CDXP's bulk payers                    ##############
5 Other payers, 2 waves                          ............
7 Moves and soaks                                .................
8 Old paths off                                       ............
9 Retire                                                          ...
```

- `=` decisions set the pace, `#` work sets the pace, and `.` waiting sets the pace (cycles, soaks, and sign-offs).
- With 2 devs per team, everything after phase 3 finishes about 3 weeks later.

## Ways to pull the date in

- Start the other payers once the first payer's Stage cycle matches, instead of after its Prod sign-off: about 4 weeks.
- Cut in the other payers in one wave instead of two: about 6 weeks, with more risk.
- A 2-week soak instead of 4: about 2 weeks.
- Two design sessions a week in phase 2: about 2 to 3 weeks.
- Together, these bring it to about 28 weeks (6 to 7 months), with more risk.
- Starting phase 4 during phase 2, if the CDXP team's tables are ready, doesn't move the end date. It does take load off CDXP during phase 5.
- Cutting effort hours, such as the C8-family change in phase 4, frees people up, but barely moves the end date. The waits set it.
