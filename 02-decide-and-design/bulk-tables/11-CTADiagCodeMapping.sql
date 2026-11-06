/*
    cdxp.CTADiagCodeMapping: one row per program, measure year and measure, with the measure's names, category, call
    to action and improvement notation. A gap reaches it through its Measure row in cdxp.BulkGapClinicalCode, on
    GapModelKey and on CodeValue = MeasureShortName.

    Base:     CDXP's own table (Ciep.Proxy.Database, DevBranch). FetchDiagnosisCodeMappingsFunction loads it from
              Snowflake REF_DW.VW_HEDIS_MEASURE_HISTORY for each quality model in cdxp.GapModels (NCQA, PQA, VPI).
              VPI reads it through the FHIR Proxy's ctamapping endpoint. C8 loads the whole view into the Portal's
              cdxp.HedisMeasureHistory (feature/pfa-refactor).
    Reworked: PayerKey and MeasureDescription are new. The Snowflake rows keep a NULL PayerKey. A payer's rows hold
              the text it sends for a measure, saved when its feed loads.
    Moved here from cdxp.BulkGapDetail: MeasureName, ShortMeasureName, MeasureDescription, MeasureCategoryName and
    CallToAction. ImprovementNotation comes back with them.

    Lookup: a gap takes its payer's row, then the Snowflake row, column by column, at the latest MeasureYear. That's
            C8's rule today (QualityCallToActionFromHedis): it matches SourceMeasureId, then ShortMeasureName, to
            MeasureShortName at the latest year, and fills the call to action only when the payer left it blank.

    Proc changes:
      spSaveCtaDiagMappings, the Snowflake load, matches only rows whose PayerKey is NULL.
      spGetCtaDiagMappings, VPI's read, returns only those rows, so VPI sees what it sees today.
      The unique key adds PayerKey: (GapModelKey, PayerKey, MeasureYear, MeasureShortName).

    Open:
      Rename it cdxp.QualityMeasure? It isn't a diagnosis mapping. Besides the two procs, a rename touches only the
        test projects' Entity Framework classes and the local cleanup script.
      Which year a gap reads: the latest, as C8 does, or its own ProgramYear when there's a row for it?
      C8 matches the short name in any program. A C8 measure outside NCQA, PQA and VPI, or with no GapModelKey,
        matches nothing here unless the lookup falls back to the short name alone.
      C8's ShortMeasureName is a label apart from its code (SourceMeasureId), and the report shows both. Keep the
        label as a column of its own, or drop it? The report's draft already asks whether it needs all of them.
      A payer that sends different text for one measure on different gaps keeps only the last load's.

    Pseudo-code: no constraints or indexes. FROM CDXP marks today's columns, which the Snowflake load fills; a payer's
    rows fill them from its feed instead. Reference data like cdxp.GapModels, so not partitioned.
*/

CREATE TABLE [cdxp].[CTADiagCodeMapping] (
	-- Keys
	[CTADiagCodeMappingKey] BIGINT            IDENTITY(1, 1),   -- FROM CDXP
	[GapModelKey]           INT               NOT NULL,         -- FROM CDXP -> cdxp.GapModels: the program (NCQA, PQA, VPI)
	[PayerKey]              SMALLINT          NULL,             -- NEW -> cdxp.Payer; NULL on the Snowflake rows
	[MeasureYear]           VARCHAR(10)       NULL,             -- FROM CDXP; payer rows: the gap's ProgramYear
	[MeasureShortName]      VARCHAR(200)      NULL,             -- FROM CDXP: the measure code on the gap's Measure row (bulk row.ShortMeasureName, C8 SourceMeasureId)

	-- The measure
	[MeasureName]           VARCHAR(MAX)      NULL,             -- FROM CDXP; payer rows: bulk row.MeasureName, C8 DetailProperties.MeasureName
	[MeasureDescription]    VARCHAR(MAX)      NULL,             -- NEW, payer rows only: bulk row.MeasureDescription, C8 DetailProperties.MeasureDescription
	[MeasureCategoryName]   VARCHAR(MAX)      NULL,             -- FROM CDXP; payer rows: bulk row.MeasureCategoryName, C8 DetailProperties.ProviderAlertsMeasureCategoryName
	[CallToActionValue]     VARCHAR(MAX)      NULL,             -- FROM CDXP; payer rows: C8 DetailProperties.CallToAction (the V5.8 spec has none)
	[ImprovementNotation]   VARCHAR(200)      NULL,             -- FROM CDXP; payer rows: C8 DetailProperties.ImprovementNotation
	[LastUpdatedDateTime]   DATETIME          NULL,             -- FROM CDXP: when Snowflake last changed the row

	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- FROM CDXP
	[InsertedBy]            NVARCHAR(128)     NOT NULL,         -- FROM CDXP
	[LastUpdated]           DATETIME          NOT NULL,         -- FROM CDXP
	[LastUpdatedBy]         NVARCHAR(128)     NOT NULL          -- FROM CDXP
);
