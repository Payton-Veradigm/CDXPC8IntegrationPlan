# Calendar timeline

[Back to the one-page plan](one-page.md)

**About 40 weeks from 2026-11-05, to mid-August 2027.** The first customer moves to the new backend in late March 2027.

- Most of the calendar is dependencies and waiting, not work: monthly side-by-side cycles and soaks.
- Team sizes vary, so the calendar isn't tied to a dev count. Where a stretch is set by work, its length comes from each team's sizing.

## Assumptions

- **Week 0** is 2026-11-05. Each week starts on a Thursday.
- **The shared data model is agreed** (phase 2), as of 2026-11-05.
- **Hours:** the dev and decision hours in each `steps.md`, as they stand today. They measure effort, not calendar time.
- **Merged team:** both teams together, from phase 8.
- **The CDXP team's Payer Automation build** (Brian) is done by week 3. The shared data model build starts during it (week 1): Brian folds those changes into his unified data model. The RAA intake buildout starts after it.
- **Collaborate's master-record removal** (Jason): dev work is done by mid-December 2026 (week 6), and it's live in TRX by mid-January 2027 (week 10).
  - Phase 7's build, starting with the Portal database copy, begins at dev done (week 6).
  - Phase 5's side-by-side runs wait for it to be live (week 10).
  - The CDXP-side work doesn't wait on it: phase 3 and the RAA intake buildout.
- **The RAA intake buildout** will likely take longer than first sized. It's planned at weeks 3 to 10. Every week past week 10 delays the first payer's side-by-side run and the first customer move by the same amount.
- **No allowance** for the December holidays.
- **Waits,** taken from the notes, or assumed where the notes leave them open:
  - First payer: two full monthly cycles side by side, Stage and then Prod.
  - Other payers: continuous, payer by payer, about 12 weeks in all.
  - Each customer's soak after its move: 4 weeks. The length is still to decide.
  - Retirement: about 3 weeks for DBOps.

## What overlaps

- **Weeks 0 to 3:** phase 6 (Josh and Payton, 3 weeks or less), the CDXP team's Payer Automation build (Brian), and the initial HNA bulk uploads (Payton) run together. So C8 devs work in CDXP's flow before any shared build starts.
- **Phase 3** (the shared data model build, about 5 weeks) runs from week 1 to week 6, alongside Payer Automation.
- **Phase 4's migration** starts once Payer Automation is done, and overlaps the rest of the shared data model build (weeks 3 to 8). Once that build is done, the consolidated tables are pushed to HNA over about 3 weeks (weeks 6 to 9). Re-pointing CDXP's readers has to be done before the first customer move.
- **Phase 5's build is the RAA intake buildout.** It runs after Payer Automation, weeks 3 to 10. Its side-by-side runs start once phase 3, the RAA intake, and the master-record removal are done, and continue payer by payer.
- **Phase 7's build** starts with the Portal database copy at Jason's dev done (week 6), after phase 3, and takes 5 to 6 weeks. PFA verification follows, done by week 16.
- **The critical path** runs through the master-record removal going live and the RAA intake (both week 10), then the first payer's two side-by-side cycles, then the first customer move. Phase 7's build and PFA verification have about 4 weeks of slack before it.
- **Phase 7's moves** follow the first payer's parity sign-off, then each payer's, so moves and side-by-side runs overlap.
- **Phase 8** follows each customer's soak, so it overlaps the later moves.
- **Phase 9** starts once the last customer's old paths are off.

## Week by week

| Phase or stretch | Weeks | Dates | Pace set by |
|---|---|---|---|
| 1. Prerequisites | 0 to 2 | Nov 5 to Nov 19 | Owners, DBOps |
| 6. Agree how we build and release | 0 to 3 | Nov 5 to Nov 26 | Decisions, 3 weeks or less (Josh and Payton) |
| CDXP team: Payer Automation build | 0 to 3 | Nov 5 to Nov 26 | CDXP team project (Brian) |
| Initial HNA bulk uploads | 0 to 3 | Nov 5 to Nov 26 | Payton, outside the plan's hours |
| 1. Master-record removal | 0 to 10 | Nov 5 to Jan 14 | Collaborate's work (Jason): dev done at week 6 (Dec 17), then the weekly releases |
| 3. Implement the shared data model | 1 to 6 | Nov 12 to Dec 17 | CDXP's work (198 h), folded into Payer Automation's unified model |
| SpecBuilder training (Ops and Product) | 3 to 7 | Nov 26 to Dec 24 | Outside the plan's hours |
| 5. RAA intake buildout (phase 5's build) | 3 to 10 | Nov 26 to Jan 14 | CDXP's work (311 h), likely to run long |
| 4. Move CDXP's bulk payers | 3 to 8 | Nov 26 to Dec 31 | CDXP's work (Brian and Payton), after Payer Automation, overlapping the shared model build |
| 4. Push the PA and shared model tables to HNA | 6 to 9 | Dec 17 to Jan 7 | CDXP's work (24 h), about 3 weeks |
| 4. Retire the per-payer tables | 21 to 23 | Apr 1 to Apr 15 | A soak after the migration |
| 7. Build for the Portal and PFA move | 6 to 12 | Dec 17 to Jan 28 | Work: 5 to 6 weeks from Jason's dev done, starting with the Portal database copy (60 h) |
| 7. Verify the PFA on the new backend | 12 to 16 | Jan 28 to Feb 25 | Collaborate's testing |
| 5. First payer side by side | 10 to 19 | Jan 14 to Mar 18 | Two monthly cycles, after the master-record removal |
| 5. Other payers side by side | 19 to 31 | Mar 18 to Jun 10 | Continuous, payer by payer |
| 7. Moves and soaks | 20 to 37 | Mar 25 to Jul 22 | A 4-week soak after each move |
| 8. Turn off the old paths | 25 to 37 | Apr 29 to Jul 22 | Each customer's soak |
| 9. Retire the old pieces | 37 to 40 | Jul 22 to Aug 12 | DBOps |

## Chart

```text
                          0    5    10   15   20   25   30   35   40
Week                      |    |    |    |    |    |    |    |    |
1 Prerequisites           ==
6 Build and release       ===
PA build (CDXP team)      ###
HNA bulk uploads          ###
1 Master-record removal   ######....   (dev done at week 6)
3 Implement                #####
SpecBuilder training         ====
5 RAA intake buildout        #######
4 CDXP's bulk payers         #####
4 HNA push, PA tables           ###
7 Build for the move            ######
7 Verify the PFA                      ....
5 First payer, 2 cycles             .........
5 Other payers                               ............
4 Retire per-payer tables                      ..
7 Moves and soaks                             .................
8 Old paths off                                    ............
9 Retire                                                       ...
```

- `=` decisions set the pace, `#` work sets the pace, and `.` waiting sets the pace (cycles, soaks, and sign-offs).

## Ways to pull the date in

- Start the other payers once the first payer's Stage cycle matches, instead of after its Prod sign-off: about 4 weeks.
- A 2-week soak instead of 4: about 2 weeks.
- Cutting effort hours frees people up, but barely moves the end date. The dependencies and waits set it.
