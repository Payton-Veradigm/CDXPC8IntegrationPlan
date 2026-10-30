/*
    cdxp.BulkGapDetail: one row per gap (1:1 with cdxp.BulkGap). The gap's own content: the FHIR-level fields
    and anything that could be reported on.

    CDXP: no table holds this today; it's only inside the FHIR bundle in blob storage (HPPGap.FileLocation).
          The fields come from HPP's inbound gap row (CDXP.Shared.Services/FlatFileFormatters/HPPFlatFileCsvBulk.cs),
          which CDXP turns into the bundle. They are marked FROM CDXP HPP row.<field>.
    C8:   alert.Detail.DetailProperties, a JSON column with the same kind of content per detail type.

    Not here, because they belong elsewhere:
      member fields in the row (names, DOB, address, PBP, Market, MetalLevel, GovernmentId, org hierarchy,
        risk contracts, LastPmrRDate, TotalParafImpact, LastAwvDate)                 -> cdxp.BulkMember
      provider fields (ProvId, Npi, Tin, names, address, SpecDesc, SiteId)           -> cdxp.BulkProvider
      the reporting provider                                                         -> cdxp.BulkProviderGap (role Reporting)
      notes (BasicText) and claim, medication, procedure, and diagnostic evidence    -> evidence/ (one to many)
      PartnerGapId, LineOfBusiness, AlertType's gap type                             -> cdxp.BulkGap
      PayerName, GlobalPayerId                                                       -> cdxp.Payer

    Pseudo-code: no constraints or indexes. Types and lengths are proposals (the HPP row model is all strings).
*/

CREATE TABLE [cdxp].[BulkGapDetail] (
	-- Keys and partition
	[PayerPartitionKey]       SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]                  BIGINT            NOT NULL,         -- NEW: 1:1 with cdxp.BulkGap

	-- Raw content
	[DetailProperties]        NVARCHAR(MAX)     NULL,             -- FROM C8 alert.Detail.DetailProperties (NOT NULL, JSON); payer attributes not promoted below

	-- Gap definition
	[AlertType]               VARCHAR(50)       NULL,             -- FROM CDXP HPP row.AlertType (mapped to BulkGap.GapTypeKey)
	[IdSource]                VARCHAR(50)       NULL,             -- FROM CDXP HPP row.IdSource
	[Period]                  VARCHAR(20)       NULL,             -- FROM CDXP HPP row.Period (program year or evaluation period)
	[EpisodeDate]             DATE              NULL,             -- FROM CDXP HPP row.EpisodeDate
	[DateOfService]           DATE              NULL,             -- FROM CDXP HPP row.Dos
	[AdditionalFlexFileName]  VARCHAR(255)      NULL,             -- FROM CDXP HPP row.AdditionalFlexFileName

	-- Quality measure
	[MeasureName]             VARCHAR(255)      NULL,             -- FROM CDXP HPP row.MeasureName
	[ShortMeasureName]        VARCHAR(100)      NULL,             -- FROM CDXP HPP row.ShortMeasureName
	[MeasureDescription]      VARCHAR(1000)     NULL,             -- FROM CDXP HPP row.MeasureDescription
	[MeasureNameModel]        VARCHAR(255)      NULL,             -- FROM CDXP HPP row.MeasureNameModel
	[MeasureCategoryName]     VARCHAR(100)      NULL,             -- FROM CDXP HPP row.MeasureCategoryName
	[StatusDescription]       VARCHAR(255)      NULL,             -- FROM CDXP HPP row.StatusDescription
	[ImprovementNotation]     VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ImprovementNotation

	-- Risk condition
	[DiagnosisCode]           VARCHAR(30)       NULL,             -- FROM CDXP HPP row.DiagnosisCode
	[DiagnosisDescription]    VARCHAR(500)      NULL,             -- FROM CDXP HPP row.DiagnosisDescription
	[ConditionCode]           VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ConditionCode (HCC)
	[DiseaseGroup]            VARCHAR(255)      NULL,             -- FROM CDXP HPP row.DiseaseGroup
	[ModelName]               VARCHAR(100)      NULL,             -- FROM CDXP HPP row.ModelName (risk model)
	[ModelNo]                 VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ModelNo
	[HierarchicalStatus]      VARCHAR(50)       NULL,             -- FROM CDXP HPP row.HierarchicalStatus
	[ConfidenceLevel]         VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ConfidenceLevel
	[RafImpact]               DECIMAL(10, 3)    NULL,             -- FROM CDXP HPP row.RafImpact

	-- Reporting organization
	[ReportingOrganization]   VARCHAR(255)      NULL,             -- FROM CDXP HPP row.ReportingOrganization

	-- Identifier sent with the gap
	[IdentifierSystem]        VARCHAR(255)      NULL,             -- FROM CDXP HPP row.System
	[IdentifierValue]         VARCHAR(255)      NULL,             -- FROM CDXP HPP row.Value

	-- Audit
	[InsertDate]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]              NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]           NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
