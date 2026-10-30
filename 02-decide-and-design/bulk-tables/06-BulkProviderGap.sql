/*
    cdxp.BulkProviderGap: which providers are tied to a gap itself, and in what role. Many-to-many between
    cdxp.BulkProvider and cdxp.BulkGap.

    Replaces:
      CDXP  cdxp.HPPGap.NPI (one NPI per gap) and the HPP row's ReportingProvider* fields
      C8    alert.Master.ProviderId and ProviderType (a provider per master record), and alert.Member.PCPId (via the member)

    Providers tied to a single piece of evidence (claim provider, prescriber, performer) are on that evidence row (evidence/).
    The provider who responded is on the feedback row (cdxp.BulkGapFeedback).

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[ProviderGapRole] (
	[ProviderGapRoleKey] TINYINT        NOT NULL,
	[Description]        VARCHAR(100)   NOT NULL,
	[IsActive]           BIT            NOT NULL,
	[InsertDate]         DATETIME       NOT NULL,
	[InsertedBy]         NVARCHAR(128)  NOT NULL,
	[LastUpdated]        DATETIME       NOT NULL,
	[LastUpdatedBy]      NVARCHAR(128)  NOT NULL
);

-- Roles. Source of each in brackets.
--   1  Attributed  the provider the gap is assigned to  [CDXP cdxp.HPPGap.NPI; C8 alert.Master.ProviderId]
--   2  PCP         the member's PCP, when the gap is delivered through it  [C8 alert.Member.PCPId]
--   3  Reporting   the provider who reported the gap  [CDXP HPP row.ReportingProviderId, ReportingProviderFirstName/LastName, ReportingProviderSpecDesc]

CREATE TABLE [cdxp].[BulkProviderGap] (
	-- Keys and partition
	[PayerPartitionKey]  SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]             BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap
	[BulkProviderKey]    BIGINT            NOT NULL,         -- NEW -> cdxp.BulkProvider; FROM CDXP cdxp.HPPGap.NPI; FROM C8 alert.Master.NPI VARCHAR(45) (resolved by NPI)
	[ProviderGapRoleKey] TINYINT           NOT NULL,         -- NEW -> cdxp.ProviderGapRole; FROM C8 alert.Master.ProviderType VARCHAR(10) for C8's attributed provider

	-- As sent
	[SpecDesc]           VARCHAR(100)      NULL,             -- FROM CDXP HPP row.ReportingProviderSpecDesc (role Reporting only)

	-- Load lineage
	[TrackerKey]         INT               NULL,             -- NEW: the CDXP run that asserted this link
	[StagingRunId]       UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that asserted this link

	-- Audit
	[InsertDate]         DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]         NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]        DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]      NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
