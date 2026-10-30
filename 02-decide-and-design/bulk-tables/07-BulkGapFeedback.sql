/*
    cdxp.BulkGapFeedback: one row per response to a gap. Many to one with cdxp.BulkGap. Every response is kept;
    IsCurrent marks the latest one per origin.

    Replaces:
      C8    the PFA set on alert.Detail (Feedback, FeedbackDate, FeedbackSourceId, FeedbackNpi, FeedbackDiagnosisCode)
            and the external / EHR set (ExternalFeedback, ExternalFeedbackNotes, ExternalFeedbackDate,
            ExternalFeedbackSource, ExternalFeedbackSourceId, ExternalSourceId), plus their history in alert.DetailHistory
      CDXP  the point-of-care response on cdxp.Gap (FeedBackTypeKey, FeedbackDate, ProviderNPIKey, ClaimID,
            ResponseSubStatus, GapComment, FeedbackFileLocation)

    C8 tracks where feedback came from at two levels, and this table keeps both:
      FeedbackOrigin  the channel that delivered it: alert.FeedbackSource.FeedbackBrokerName = PFA, CDXP, VIM Bulk
      FeedbackSource  the system it came from: PFA, or the EHR in alert.ExternalSource.ExternalSourceName =
                      VIM Bulk, Veradigm Pro, Practice Fusion, Epic, Athena, NextGen
      alert.GetAlertExport derives FeedbackSource the same way: 'PFA' when the broker is PFA, otherwise the external source.

    Open:
      one current response per gap, or per origin? (C8 holds a PFA answer and an EHR answer at once today)
      merge C8's per-tenant alert.FeedbackType (limited per gap type by alert.DetailType_FeedbackType) with CDXP's global cdxp.FeedBackType
      FeedbackOrigin and FeedbackSource as text here, or as keys to lookup tables

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapFeedback] (
	-- Keys and partition
	[PayerPartitionKey]     SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapFeedbackKey]        BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]                BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The response
	[FeedbackTypeKey]       INT               NOT NULL,         -- FROM C8 alert.Detail.Feedback (-> alert.FeedbackType) and alert.Detail.ExternalFeedback VARCHAR(100); FROM CDXP cdxp.Gap.FeedBackTypeKey (-> cdxp.FeedBackType)
	[FeedbackDate]          DATETIME2         NOT NULL,         -- FROM C8 alert.Detail.FeedbackDate / alert.Detail.ExternalFeedbackDate; FROM CDXP cdxp.Gap.FeedbackDate
	[DiagnosisCode]         VARCHAR(30)       NULL,             -- FROM C8 alert.Detail.FeedbackDiagnosisCode
	[ClaimId]               VARCHAR(100)      NULL,             -- FROM CDXP cdxp.Gap.ClaimID
	[SubStatus]             VARCHAR(500)      NULL,             -- FROM CDXP cdxp.Gap.ResponseSubStatus
	[Notes]                 VARCHAR(MAX)      NULL,             -- FROM C8 alert.Detail.ExternalFeedbackNotes; FROM CDXP cdxp.Gap.GapComment

	-- Where it came from
	[FeedbackOrigin]           VARCHAR(50)       NOT NULL,      -- FROM C8 alert.FeedbackSource.FeedbackBrokerName via alert.Detail.FeedbackSourceId (PFA, CDXP, VIM Bulk)
	[FeedbackSource]           VARCHAR(200)      NOT NULL,      -- FROM C8 alert.Detail.ExternalFeedbackSource / alert.ExternalSource.ExternalSourceName ('PFA' for PFA responses)
	[FeedbackSourceId]         UNIQUEIDENTIFIER  NULL,          -- FROM C8 alert.Detail.FeedbackSourceId -> alert.FeedbackSource
	[ExternalSourceId]         UNIQUEIDENTIFIER  NULL,          -- FROM C8 alert.Detail.ExternalSourceId -> alert.ExternalSource
	[ExternalFeedbackSourceId] UNIQUEIDENTIFIER  NULL,          -- FROM C8 alert.Detail.ExternalFeedbackSourceId

	-- Who responded
	[BulkProviderKey]       BIGINT            NULL,             -- NEW -> cdxp.BulkProvider; FROM CDXP cdxp.Gap.ProviderNPIKey; FROM C8 alert.Detail.FeedbackNpi VARCHAR(45) (resolved by NPI)
	[FeedbackUser]          NVARCHAR(256)     NULL,             -- FROM C8 alert.Detail.UpdatedBy today (FeedbackUser on jk/pfa-refactor)

	-- Content pointer
	[FeedbackFileLocation]  VARCHAR(500)      NULL,             -- FROM CDXP cdxp.Gap.FeedbackFileLocation; goes away once content lives in SQL

	-- State
	[IsCurrent]             BIT               NOT NULL,         -- NEW: the latest response from this origin

	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]            NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]           DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]         NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
