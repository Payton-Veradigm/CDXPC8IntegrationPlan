/*
    cdxp.BulkGapDiagnosticEvidence: diagnostic reports (labs, imaging) that support a gap. Many to one with cdxp.BulkGap.

    CDXP: HPP's gap row carries one diagnostic report (Diagnostic* fields), written into the FHIR bundle as a
          DiagnosticReport. Marked FROM CDXP HPP row.<field>.
    C8:   no diagnostic columns in alert.Detail; any such content is inside DetailProperties.

    The performer is a cdxp.BulkProvider row (found or created by NPI); the HPP row's
    DiagnosticNpi, DiagnosticFirstName, and DiagnosticLastName land on that provider.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (../00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapDiagnosticEvidence] (
	-- Keys and partition
	[PayerPartitionKey]       SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[DiagnosticEvidenceKey]   BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]                  BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The report
	[IssuedDateTime]          DATETIME2         NULL,             -- FROM CDXP HPP row.DiagnosticIssuedDateTime
	[DiagnosticCode]          VARCHAR(50)       NULL,             -- FROM CDXP HPP row.DiagnosticCode
	[DiagnosticCodeSystem]    VARCHAR(255)      NULL,             -- NEW: the code's FHIR coding system (LOINC); HPP's row doesn't send one
	[DiagnosticDisplay]       VARCHAR(500)      NULL,             -- FROM CDXP HPP row.DiagnosticDisplay

	-- Who performed it
	[BulkProviderKey]         BIGINT            NULL,             -- NEW -> cdxp.BulkProvider
	[Organization]            VARCHAR(255)      NULL,             -- FROM CDXP HPP row.DiagnosticOrganization

	-- Load lineage
	[TrackerKey]              INT               NULL,             -- NEW: the CDXP run that sent it
	[StagingRunId]            UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that sent it

	-- Audit
	[InsertDate]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]              NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]           NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);