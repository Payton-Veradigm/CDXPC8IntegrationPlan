/*
    cdxp.BulkGap: one row per gap. Holds identity, classification, delivery status, and program lifecycle.

    Elsewhere:
      content (FHIR-level fields, DetailProperties)  -> cdxp.BulkGapDetail
      feedback (PFA, EHR, payer responses)           -> cdxp.BulkGapFeedback
      providers and their roles                      -> cdxp.BulkProviderGap (replaces cdxp.HPPGap.NPI)
      clinical codes (HCC, ICD-10, measure)          -> cdxp.BulkGapClinicalCode (PA-4)
      evidence (notes, claims, medications, procedures, diagnostics) -> blob storage only, in the bundle at FileLocation

    Base:    cdxp.HPPGap (CDXP).
    Laid in: alert.Detail (C8), marked FROM C8, minus DetailProperties (BulkGapDetail), the feedback columns
             (BulkGapFeedback), and AlertCompletedDateId (retired).

    The lifecycle, period, and GapSource columns are from feature/pfa-refactor, which isn't in Prod yet.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGap] (
	-- Keys and partition
	[PayerPartitionKey]        SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]                   BIGINT            IDENTITY(1, 1),   -- FROM CDXP cdxp.HPPGap.GapKey
	[MemberKey]                BIGINT            NOT NULL,         -- FROM CDXP cdxp.HPPGap.MemberKey; FROM C8 alert.Detail.AlertMemberId UNIQUEIDENTIFIER (resolved to BulkMember)
	[DetailId]                 INT               NULL,             -- FROM C8 alert.Detail.DetailId (TRX's gap ID; keep for reconciliation)
	[MasterId]                 INT               NULL,             -- FROM C8 alert.Detail.MasterId (retired by the master-record removal)

	-- Classification
	[GapTypeKey]               TINYINT           NOT NULL,         -- FROM CDXP cdxp.HPPGap.GapTypeKey -> cdxp.GapType
	[LineOfBusinessKey]        TINYINT           NULL,             -- FROM CDXP cdxp.HPPGap.LineOfBusinessKey; FROM C8 alert.Detail.LOB VARCHAR(10)
	[DetailTypeId]             INT               NULL,             -- FROM C8 alert.Detail.DetailTypeId (NOT NULL in C8) -> alert.DetailType, the tenant's gap type
	[DetailCode]               VARCHAR(200)      NULL,             -- FROM C8 alert.Detail.DetailCode (condition or measure code)
	[GapSource]                VARCHAR(50)       NULL,             -- FROM C8 alert.Detail.GapSource: where the gap originated

	-- Period (C8)
	[EvaluationPeriod]         INT               NULL,             -- FROM CDXP HPP row.Period, converted from its date range; FROM C8 alert.Detail.EvaluationPeriod (risk and quality)
	[ProgramYear]              INT               NULL,             -- FROM CDXP HPP row.Period for quality; FROM C8 alert.Detail.ProgramYear (quality only; NULL for risk)

	-- Payer gap identifiers
	[PayerGapId]               VARCHAR(150)      NULL,             -- FROM CDXP cdxp.HPPGap.PayerGapId (NOT NULL there); FROM C8 alert.Detail.PartnerGapId VARCHAR(60)
	[InternalGapId]            VARCHAR(MAX)      NULL,             -- FROM C8 alert.Detail.InternalGapId (fallback when the payer sends no gap ID)

	-- Delivery status (CDXP)
	[GapStatusKey]             TINYINT           NOT NULL,         -- FROM CDXP cdxp.HPPGap.GapStatusKey -> cdxp.GapStatus

	-- Program lifecycle (C8)
	[IsInSource]               BIT               NOT NULL,         -- FROM C8 alert.Detail.IsInSource (isActive before feature/pfa-refactor)
	[IsExpired]                BIT               NOT NULL,         -- FROM C8 alert.Detail.IsExpired: payer-configured expiry, apart from leaving the source
	[ExpiredDate]              DATETIME2         NULL,             -- FROM C8 alert.Detail.ExpiredDate
	[ClosedDate]               DATETIME2         NULL,             -- NEW: when IsInSource went to 0 or IsExpired went to 1, NULL while open; C8 has no column for it

	-- Content pointer
	[FileLocation]             VARCHAR(500)      NULL,             -- FROM CDXP cdxp.HPPGap.FileLocation (NOT NULL there): the FHIR bundle in blob, the only copy of the gap's evidence

	-- Load lineage
	[FileDetailKey]            BIGINT            NULL,             -- FROM CDXP cdxp.HPPGap.FileDetailKey (NOT NULL there; cdxp.HPPFileDetail today)
	[TrackerKey]               INT               NULL,             -- FROM CDXP cdxp.HPPGap.TrackerKey (the run; cdxp.HPPTracker today)
	[FirstStagingRunId]        UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Detail.FirstStagingRunId
	[LastStagingRunId]         UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Detail.LastStagingRunId

	-- Audit
	[InsertDate]               DATETIME          NOT NULL,         -- FROM CDXP cdxp.HPPGap.InsertDate; FROM C8 alert.Detail.CreateDate DATETIME2
	[InsertedBy]               NVARCHAR(128)     NOT NULL,         -- FROM CDXP cdxp.HPPGap.InsertedBy
	[LastUpdated]              DATETIME          NOT NULL,         -- FROM CDXP cdxp.HPPGap.LastUpdated; FROM C8 alert.Detail.UpdateDate DATETIME2
	[LastUpdatedBy]            NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.HPPGap.LastUpdatedBy; FROM C8 alert.Detail.UpdatedBy NVARCHAR(MAX)
);
