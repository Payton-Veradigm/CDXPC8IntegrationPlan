/*
    cdxp.QualityMeasure: one row per quality measure: the names, description, category and call to action its code
    stands for. A gap reaches it through its Measure row in cdxp.BulkGapClinicalCode, on CodeSystem and CodeValue.

    Base:  C8's measure reference in the Portal database. cdxp.HedisMeasureHistory holds the name, short name,
           category and call to action, loaded nightly from Snowflake; the older cdxp.QualityCallToAction also has
           the description. CDXP has none; its bulk row repeats these values on every gap.
    Moved here from cdxp.BulkGapDetail: MeasureName, ShortMeasureName, MeasureDescription, MeasureCategoryName,
    CallToAction.

    Reference data like cdxp.GapModels, so not partitioned. PayerKey is NULL for a program's measures (NCQA, PQA)
    and set for a measure only one payer defines, since two payers' own codes can collide.

    Open:
      C8's history has a row per measure year and uses the latest. One row per measure, or key on the year too?
      Payers send their own text on every gap. When it differs from the reference, which wins?

    Pseudo-code: no constraints or indexes.
*/

CREATE TABLE [cdxp].[QualityMeasure] (
	-- Keys
	[QualityMeasureKey]     INT               IDENTITY(1, 1),   -- NEW
	[PayerKey]              SMALLINT          NULL,             -- NEW -> cdxp.Payer; NULL for a program's measures
	-- Needs to be payer specific
	[CodeSystem]            VARCHAR(50)       NOT NULL,         -- NEW: the program, as on the Measure row in cdxp.BulkGapClinicalCode (NCQA, PQA, VPI)
	[CodeValue]             VARCHAR(50)       NOT NULL,         -- NEW: the measure code, as on that row (the bulk row's ShortMeasureName, C8's SourceMeasureId)

	-- The measure
	[MeasureName]           VARCHAR(255)      NULL,             -- FROM CDXP bulk row.MeasureName; FROM C8 cdxp.HedisMeasureHistory.MeasureName
	[ShortMeasureName]      VARCHAR(100)      NULL,             -- FROM CDXP bulk row.ShortMeasureName; FROM C8 cdxp.HedisMeasureHistory.MeasureShortName
	[MeasureDescription]    VARCHAR(1000)     NULL,             -- FROM CDXP bulk row.MeasureDescription; FROM C8 cdxp.QualityCallToAction.MeasureDescription
	[MeasureCategoryName]   VARCHAR(100)      NULL,             -- FROM CDXP bulk row.MeasureCategoryName; FROM C8 cdxp.HedisMeasureHistory.MeasureCategoryName
	[CallToAction]          VARCHAR(500)      NULL,             -- FROM C8 cdxp.HedisMeasureHistory.CallToActionValue NVARCHAR(MAX)

	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]            NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]           DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]         NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
