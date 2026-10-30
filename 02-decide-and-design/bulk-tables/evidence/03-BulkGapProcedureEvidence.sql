/*
    cdxp.BulkGapProcedureEvidence: procedures that support a gap. Many to one with cdxp.BulkGap.

    CDXP: HPP's gap row carries one procedure (Procedure* fields), written into the FHIR bundle. Marked FROM CDXP HPP row.<field>.
    C8:   no procedure columns in alert.Detail; any procedure content is inside DetailProperties.

    The performer is a cdxp.BulkProvider row (found or created by NPI); the HPP row's
    ProcedurePerformerNpi, ProcedurePerformerFirstName, and ProcedurePerformerLastName land on that provider.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (../00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapProcedureEvidence] (
	-- Keys and partition
	[PayerPartitionKey]      SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[ProcedureEvidenceKey]   BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]                 BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The procedure
	[PerformedDateTime]      DATETIME2         NULL,             -- FROM CDXP HPP row.ProcedurePerformedDateTime
	[ProcedureCode]          VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ProcedureCode
	[ProcedureCodeSystem]    VARCHAR(255)      NULL,             -- NEW: the code's FHIR coding system (CPT, HCPCS, ICD-10-PCS); HPP's row doesn't send one
	[ProcedureDisplay]       VARCHAR(500)      NULL,             -- FROM CDXP HPP row.ProcedureDisplay
	[ProcedureModelName]     VARCHAR(100)      NULL,             -- FROM CDXP HPP row.ProcedureModelName

	-- Who performed it
	[BulkProviderKey]        BIGINT            NULL,             -- NEW -> cdxp.BulkProvider
	[Organization]           VARCHAR(255)      NULL,             -- FROM CDXP HPP row.ProcedureOrganization

	-- Load lineage
	[TrackerKey]             INT               NULL,             -- NEW: the CDXP run that sent it
	[StagingRunId]           UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that sent it

	-- Audit
	[InsertDate]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]             NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]            DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]          NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);