/*
    cdxp.BulkGapDetail: one row per gap (1:1 with cdxp.BulkGap). The gap's own content: the FHIR-level fields
    and anything that could be reported on.

    CDXP: no table holds this today; it's only inside the FHIR bundle in blob storage (<Payer>Gap.FileLocation).
          The fields come from CDXP's bulk gap row, which its flat-file formatters read
          (CDXP.Shared.Services/FlatFileFormatters/*FlatFileCsvBulk.cs), the V5.8 spec now defines, and CDXP turns
          into the bundle. They are marked FROM CDXP bulk row.<field>.
    C8:   alert.Detail.DetailProperties, a JSON column with the same kind of content per detail type.

    Not here, because they belong elsewhere:
      member fields in the row (names, DOB, address, PBP, Market, MetalLevel, GovernmentId, org hierarchy,
        risk contracts, LastPmrRDate, TotalParafImpact, LastAwvDate)                 -> cdxp.BulkMember
      provider fields (ProvId, Npi, Tin, names, address, SpecDesc, SiteId)           -> cdxp.Provider (Npi) and cdxp.PayerProvider
      the reporting provider                                                         -> cdxp.BulkProviderGap (role Reporting)
      notes (BasicText) and claim, medication, procedure, and diagnostic evidence    -> blob storage only (bundle at BulkGap.FileLocation)
      PartnerGapId, LineOfBusiness, AlertType (GapTypeKey),
        Period (EvaluationPeriod, ProgramYear)                                       -> cdxp.BulkGap
      bulk row.System and Value, an identifier the V5.8 spec doesn't carry           -> the bundle; cdxp.BulkGapClinicalCode.CodeExtension when it's that identifier
      PayerName, GlobalPayerId                                                       -> cdxp.Payer
      the gap's codes                                                                -> cdxp.BulkGapClinicalCode (PA-4), one row per code
        risk:    a Measure row (CodeSystem ModelName, CodeVersion ModelNo, CodeValue ConditionCode) and a Diagnosis
                 row (CodeValue DiagnosisCode); the spec and C8 send one diagnosis per gap
        quality: a Measure row (CodeSystem MeasureNameModel, CodeValue the measure code: the bulk row's
                 ShortMeasureName, C8's SourceMeasureId)

    Open: C8's Rx gaps keep their medication fields in DetailProperties (NDCName, NDC, GPI14, TherapeuticCategory,
          Dosage, DaysSupply, Quantity, LastFill, AlternateConsiderations), reported as the Rx* columns of
          report.ProviderAlertFeedbackResponse. If they're medication-adherence gap content rather than evidence, they
          need columns here before DetailProperties can go; evidence stays in blob.

    Pseudo-code: no constraints or indexes. Types and lengths are proposals (the bulk row model is all strings).
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

	-- Quality measure
	==================================
	-- Can we lookup/librarize/reference table these values, since they ~SHOULD~ be tied together
	[MeasureName]             VARCHAR(255)      NULL,             -- FROM CDXP bulk row.MeasureName
	[ShortMeasureName]        VARCHAR(100)      NULL,             -- FROM CDXP bulk row.ShortMeasureName (also the bulk format's measure code); C8's is a label, apart from its code
	[MeasureDescription]      VARCHAR(1000)     NULL,             -- FROM CDXP bulk row.MeasureDescription
	[MeasureCategoryName]     VARCHAR(100)      NULL,             -- FROM CDXP bulk row.MeasureCategoryName
	[CallToAction]            VARCHAR(500)      NULL,             -- FROM C8 DetailProperties.CallToAction (staged from Quality Analytics or Portal's cdxp.HedisMeasureHistory)

	[StatusDescription]       VARCHAR(255)      NULL,             -- FROM CDXP bulk row.StatusDescription (non-compliant or compliant)
	[Notes]                   VARCHAR(500)      NULL,             -- FROM C8 DetailProperties.Notes (a MeasureReport extension in C8's FHIR, not Basic evidence)
	-- Look at the values in C8 db


	-- Risk condition
	==================================
	[DiagnosisDescription]    VARCHAR(500)      NULL,             -- FROM CDXP bulk row.DiagnosisDescription: describes the gap's Diagnosis code row
	-- Could link directly to clinical Diagnosis code, reference table-able
	
	[ConfidenceLevel]         VARCHAR(50)       NULL,             -- FROM CDXP bulk row.ConfidenceLevel
	[RafImpact]               DECIMAL(10, 3)    NULL,             -- FROM CDXP bulk row.RafImpact
	[FactoredRafImpact]       DECIMAL(10, 3)    NULL,             -- FROM C8 DetailProperties.FactoredRAFImpact (alert.vw_GapStatus reads it too)
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
