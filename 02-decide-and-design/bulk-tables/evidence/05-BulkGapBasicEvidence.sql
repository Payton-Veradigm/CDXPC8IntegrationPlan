/*
    cdxp.BulkGapBasicEvidence: free-text evidence (notes) that supports a gap. Many to one with cdxp.BulkGap.

    In FHIR this is a Basic resource that the gap's Condition lists under evidence.detail. CDXP builds it with
    the text as Basic.code.coding.display and the extension
    https://partner.identifier.com/StructureDefinition/evidence-type = NOTES (the only value CDXP's code sends).
    It has no code and no provider.

    CDXP: HPP's gap row carries one note (BasicText), so a flat-file gap has at most one.
          Gaps that arrive as FHIR can carry several: VpiBatchHandler reads every Basic in Condition.evidence.
    C8:   no notes columns in alert.Detail. C8 sends evidence as FHIR (VpiBatchHandler handles C8's untyped
          evidence references), so its notes arrive the same way.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (../00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapBasicEvidence] (
	-- Keys and partition
	[PayerPartitionKey]   SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[BasicEvidenceKey]    BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]              BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The note
	[EvidenceType]        VARCHAR(50)       NOT NULL,         -- FROM CDXP the evidence-type extension on Basic ('NOTES')
	[Text]                VARCHAR(MAX)      NOT NULL,         -- FROM CDXP HPP row.BasicText (Basic.code.coding.display)

	-- Load lineage
	[TrackerKey]          INT               NULL,             -- NEW: the CDXP run that sent it
	[StagingRunId]        UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that sent it

	-- Audit
	[InsertDate]          DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]          NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]         DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]       NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
