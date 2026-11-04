/*
    cdxp.BulkProviderGap: which providers are tied to a gap itself, and in what role. Many-to-many between
    providers (cdxp.Provider) and cdxp.BulkGap.

    Replaces:
      CDXP  cdxp.<Payer>Gap.NPI (one NPI per gap) and the bulk row's ReportingProvider* fields
      C8    alert.Detail.ProviderId (the gap's provider on feature/pfa-refactor; alert.Master.ProviderId in Prod),
            and alert.Member.PCPId (via the member)

    Each gap has exactly one Attributed row: the provider the gap was sent under. cdxp.BulkGapAccess builds its keys
    from it, so it decides which Provider SSO users see the gap. The PCP row can't stand in: C8's analytics gaps carry
    their own provider (PRVDR_ID), which can differ from the member's PCP. Only gaps sent without a provider, and OTB's
    FHIR risk gaps, fall back to the PCP.

    A link names its provider by ProviderKey (the NPI) and PayerProviderId (the payer's ID, which finds
    cdxp.PayerProvider on the gap's LOB). At least one is set: some payer providers have no NPI.

    Providers tied to a single piece of evidence (claim provider, prescriber, performer) stay with the evidence in blob storage.
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
--   1  Attributed  the provider the gap is assigned to, exactly one per gap  [CDXP cdxp.<Payer>Gap.NPI; C8 alert.Detail.ProviderId]
--   2  PCP         the member's PCP, when the gap is delivered through it  [C8 alert.Member.PCPId]
--   3  Reporting   the provider who reported the gap  [CDXP bulk row.ReportingProviderId, ReportingProviderFirstName/LastName, ReportingProviderSpecDesc]

CREATE TABLE [cdxp].[BulkProviderGap] (
	-- Keys and partition
	[PayerPartitionKey]  SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]             BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap
	[ProviderKey]        BIGINT            NULL,             -- NEW -> cdxp.Provider, resolved by NPI; FROM CDXP cdxp.<Payer>Gap.NPI; NULL when the provider has no NPI
	[PayerProviderId]    VARCHAR(100)      NULL,             -- FROM CDXP bulk row.ProvId or ReportingProviderId; FROM C8 alert.Detail.ProviderId, alert.Member.PCPId, or the diagnosis's ReportingProviderId
	[ProviderGapRoleKey] TINYINT           NOT NULL,         -- NEW -> cdxp.ProviderGapRole

	-- As sent
	[SpecDesc]           VARCHAR(100)      NULL,             -- FROM CDXP bulk row.ReportingProviderSpecDesc (role Reporting only)

	-- Load lineage
	[TrackerKey]         INT               NULL,             -- NEW: the CDXP run that asserted this link

	-- Audit
	[InsertDate]         DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]         NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]        DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]      NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
