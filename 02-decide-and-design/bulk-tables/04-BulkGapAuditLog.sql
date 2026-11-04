/*
    cdxp.BulkGapAuditLog: one row per change to a gap's status or lifecycle.

    Base:    cdxp.HPPGapAuditLog (CDXP), which logs every GapStatusKey change.
    Laid in: the alert.Detail lifecycle columns (C8) whose changes C8 tracks today in alert.DetailHistory (trigger tr_DetailHistory).
    Feedback history isn't logged here: every response is its own row in cdxp.BulkGapFeedback.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapAuditLog] (
	-- Keys and partition
	[PayerPartitionKey]     SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapAuditLogKey]        BIGINT            IDENTITY(1, 1),   -- FROM CDXP cdxp.HPPGapAuditLog.GapAuditLogKey; FROM C8 alert.DetailHistory.DetailHistoryId
	[GapKey]                BIGINT            NOT NULL,         -- FROM CDXP cdxp.HPPGapAuditLog.GapKey; FROM C8 alert.DetailHistory.DetailId

	-- Delivery status (CDXP)
	[GapStatusKey]          TINYINT           NOT NULL,         -- FROM CDXP cdxp.HPPGapAuditLog.GapStatusKey
	[Source]                VARCHAR(20)       NULL,             -- FROM CDXP cdxp.HPPGapAuditLog.Source
	[IsDuplicate]           BIT               NULL,             -- FROM CDXP cdxp.HPPGapAuditLog.IsDuplicate

	-- Program lifecycle (C8)
	[IsInSource]            BIT               NULL,             -- FROM C8 alert.Detail.IsInSource (isActive before feature/pfa-refactor)
	[IsExpired]             BIT               NULL,             -- FROM C8 alert.Detail.IsExpired
	[LatestActivationDate]  DATETIME2         NULL,             -- FROM C8 alert.Detail.LatestActivationDate

	-- Load lineage
	[LastStagingRunId]      UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Detail.LastStagingRunId

	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- FROM CDXP cdxp.HPPGapAuditLog.InsertDate; FROM C8 alert.DetailHistory.UpdateDate
	[InsertedBy]            NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.HPPGapAuditLog.InsertedBy; FROM C8 alert.Detail.UpdatedBy
);
