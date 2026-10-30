/*
    cdxp.BulkGapClaimEvidence: claims that support a gap. Many to one with cdxp.BulkGap.

    CDXP: HPP's gap row carries one claim (Claim* fields), written into the FHIR bundle. Marked FROM CDXP HPP row.<field>.
    C8:   no claim evidence columns in alert.Detail; any claim content is inside DetailProperties.

    The claim provider is a cdxp.BulkProvider row (found or created by NPI); the HPP row's
    ClaimProviderNpi, ClaimProviderFirstName, and ClaimProviderLastName land on that provider.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (../00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapClaimEvidence] (
	-- Keys and partition
	[PayerPartitionKey]   SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[ClaimEvidenceKey]    BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]              BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The claim
	[ClaimDate]           DATE              NULL,             -- FROM CDXP HPP row.ClaimDate
	[ClaimType]           VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ClaimType
	[ClaimPriority]       VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ClaimPriority
	[ClaimCode]           VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ClaimCode
	[ClaimCodeSystem]     VARCHAR(255)      NULL,             -- NEW: the code's FHIR coding system; HPP's row doesn't send one
	[ClaimDisplay]        VARCHAR(500)      NULL,             -- FROM CDXP HPP row.ClaimDisplay
	[ClaimModelName]      VARCHAR(100)      NULL,             -- FROM CDXP HPP row.ClaimModelName

	-- Who billed it
	[BulkProviderKey]     BIGINT            NULL,             -- NEW -> cdxp.BulkProvider
	[Organization]        VARCHAR(255)      NULL,             -- FROM CDXP HPP row.ClaimOrganization

	-- Load lineage
	[TrackerKey]          INT               NULL,             -- NEW: the CDXP run that sent it
	[StagingRunId]        UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that sent it

	-- Audit
	[InsertDate]          DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]          NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]         DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]       NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);