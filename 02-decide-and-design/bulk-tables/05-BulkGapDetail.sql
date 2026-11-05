/*
    cdxp.BulkGapDetail: the gap's own content, one row per gap (1:1 with cdxp.BulkGap).

    CDXP: only inside the FHIR bundle today (<Payer>Gap.FileLocation). Fields marked FROM CDXP bulk row.<field>
          come from the bulk gap row CDXP's flat-file formatters read, which the V5.8 spec now defines.
    C8:   alert.Detail.DetailProperties, a JSON column.

    Elsewhere:
      member and provider fields                          -> cdxp.BulkMember and the provider tables
      period, gap type, LOB and partner gap ID            -> cdxp.BulkGap
      the gap's codes                                     -> cdxp.BulkGapClinicalCode
      measure name, short name, description, category
        and call to action                                -> cdxp.QualityMeasure, by the gap's Measure code
      diagnosis description                               -> cdxp.DiagnosisCode, by the gap's Diagnosis code
      evidence, including the bulk row's BasicText notes  -> blob storage only

    Open: C8's Rx gaps keep their medication fields (NDC, GPI14, dosage, days supply, quantity, last fill) in
          DetailProperties. If they're gap content, they need columns here.

    Pseudo-code: no constraints or indexes. Types and lengths are proposals.
*/

CREATE TABLE [cdxp].[BulkGapDetail] (
	-- Keys and partition
	[PayerPartitionKey]       SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]                  BIGINT            NOT NULL,         -- NEW: 1:1 with cdxp.BulkGap

	-- Gap definition
	[IdSource]                VARCHAR(50)       NULL,             -- FROM CDXP bulk row.IdSource
	[EpisodeDate]             DATE              NULL,             -- FROM CDXP bulk row.EpisodeDate
	[DateOfService]           DATE              NULL,             -- FROM CDXP bulk row.Dos
	[AdditionalFlexFileName]  VARCHAR(255)      NULL,             -- FROM CDXP bulk row.AdditionalFlexFileName

	-- Quality measure (its names, description, category and call to action are in cdxp.QualityMeasure)
	[StatusDescription]       VARCHAR(255)      NULL,             -- FROM CDXP bulk row.StatusDescription (non-compliant or compliant)
	[Notes]                   VARCHAR(500)      NULL,             -- FROM C8 DetailProperties.Notes; not the bulk row's BasicText, which is evidence
	-- Look at the values in C8 db

	-- Risk condition (the diagnosis description is in cdxp.DiagnosisCode)
	[ConfidenceLevel]         VARCHAR(50)       NULL,             -- FROM CDXP bulk row.ConfidenceLevel
	[RafImpact]               DECIMAL(10, 3)    NULL,             -- FROM CDXP bulk row.RafImpact
	[FactoredRafImpact]       DECIMAL(10, 3)    NULL,             -- FROM C8 DetailProperties.FactoredRAFImpact
	[FinancialImpact]         DECIMAL(12, 2)    NULL,             -- FROM C8 DetailProperties.FinancialImpact
	[FactoredFinancialImpact] DECIMAL(12, 2)    NULL,             -- FROM C8 DetailProperties.FactoredFinancialImpact

	-- Reporting organization
	[ReportingOrganization]   VARCHAR(255)      NULL,             -- FROM CDXP bulk row.ReportingOrganization

	-- Audit
	[InsertDate]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]              NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]           NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
