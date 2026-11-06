# Backfill and release it to every TRX database

[Back to steps](../steps.md)

- **Scripts on the branch:**
  - The backfills: `PST_202609.02_BackfillPfaMemberAndGapData` and `PST_202610.01_BackfillDocumentMember`, with tests.
  - `PST_202610.03_DropRetiredMasterObjects`, which drops the retired master objects.
- **Order:** Dev, QA, Stage (a copy of production data), then Prod, through the weekly releases. DBOps reviews each Prod preview.
- **Which databases:** the 20 customer databases and the 4 copies in `db/DatabaseConfig.json`. Dormant ones can be archived instead (see [the baseline](baseline-trx.md)).
- **Check each customer:** row counts, plus spot checks of members, gaps, feedback, and documents, before and after.
- **Calendar:** about 4 to 6 weeks of weekly releases. It has to be live in Prod before phase 7's build and phase 5's first side-by-side run.
  - As of 2026-11-05, Jason expects the dev work done by mid-December 2026 and the release live in mid-January 2027. Phase 7's build, starting with the Portal database copy, can start at dev done. The CDXP-side work (phase 3 and the RAA intake buildout) doesn't wait on it.
- **Open:** FHIR Publish now picks gaps by member and PCP, and the FHIR mapping code changed, though the intake routes didn't. Confirm with CDXP what VPI will show before Prod.
