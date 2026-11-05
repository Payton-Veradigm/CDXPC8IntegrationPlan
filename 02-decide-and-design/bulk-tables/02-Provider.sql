/*
    cdxp.PayerProvider: a payer's record of a provider, on top of cdxp.Provider. cdxp.Provider holds what's true of
    the NPI everywhere (name, taxonomy classification); this table adds what the payer says about it.

    Base:    cdxp.Provider (CDXP), global since PR 53441: one row per NPI. Its columns aren't repeated here, except
             the NPI as the payer sent it, which the access keys need.
    Laid in: the rest of alert.Provider (C8), marked FROM C8.

    Columns marked "access key" are what cdxp.BulkGapAccess is built from, as C8's alert.BuildMapping builds
    alert.Mapping from alert.Provider.

    One row per payer provider ID and LOB, C8's key for alert.Provider. One NPI can have several: C8 keeps a
    provider's payer IDs apart, their TINs and groups can differ, and the access keys and Not Seen Here depend on it.
    A payer that sends only NPIs has one row per NPI and LOB, with no PayerProviderId. ProviderKey is NULL when the
    payer sent no NPI, since cdxp.Provider requires one.

    Other tables tie to a provider by ProviderKey. Where C8 tells payer IDs apart (cdxp.BulkProviderGap and
    cdxp.BulkMemberProviderStatus), they also carry PayerProviderId, which finds this row on the gap's or member's LOB.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[Provider] (
	-- Keys and partition
	[PayerPartitionKey]             SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[ProviderKey]                   BIGINT            NULL,             -- NEW -> cdxp.Provider, which has the NPI, name and taxonomy classification; NULL when the payer sent no NPI
	[LineOfBusinessKey]             TINYINT           NULL,             -- FROM C8 alert.Provider.LOB VARCHAR(10); part of C8's unique key (LOB, ProviderId), which finds the gap's provider
	[PayerProviderId]               VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.ProviderId (NOT NULL in C8); FROM CDXP bulk row.ProvId; alert.Member.PCPId points at it; access key PROVIDER_ID

	-- Provider identifiers
	[NPI]                           VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.NPI; FROM CDXP bulk row.Npi; access key NPI, kept as sent so it still matches when it isn't in cdxp.Provider
	[RAAFilteringTIN]                           VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.TIN; FROM CDXP the V5.8 spec's TIN, recorded at ingestion; access key PROVIDER_TIN
	-- Used for Gap Access, not to be confused with the tin associated with the providers sites.

	-- Name as the payer sent it; cdxp.Provider.ProviderName is the NPI's
	[FirstName]                     NVARCHAR(45)      NULL,             -- FROM C8 alert.Provider.FirstName
	[LastName]                      NVARCHAR(255)     NULL,             -- FROM C8 alert.Provider.LastName

	-- Specialty as the payer sent it; cdxp.Provider has the taxonomy classification
	[SpecCode]                      VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.SpecCode (payer's specialty code, not a taxonomy)
	[SpecDesc]                      VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SpecDesc

	-- Org hierarchy and contracts (drive C8 access mapping and reports)
	[GroupId]                       VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.GroupId; access key GROUP_ID, unless the member is MemberDriven
	[GroupName]                     VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.GroupName; access key GROUP_ID, unless the member is MemberDriven
	[SuperGroupID]                  VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SuperGroupID
	[SuperGroupName]                VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.SuperGroupName
	[MedCenter]                     VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.MedCenter; access key MED_CENTER, unless the member is MemberDriven
	[MedCenterDesc]                 VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.MedCenterDesc
	[SettlementEntityID]            VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SettlementEntityID
	[SettlementEntityName]          VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.SettlementEntityName
	[Risk_Contract_ID]              VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_ID
	[Risk_Contract_Group]           VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_Group
	[Risk_Contract_Class]           VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_Class; access key RISK_CONTRACT_CLASS, unless the member is MemberDriven

	-- Address and contact
	[Address1]                      VARCHAR(1000)     NULL,             -- FROM C8 alert.Provider.Address1
	[Address2]                      VARCHAR(1000)     NULL,             -- FROM C8 alert.Provider.Address2
	[City]                          VARCHAR(250)      NULL,             -- FROM C8 alert.Provider.City
	[State]                         VARCHAR(25)       NULL,             -- FROM C8 alert.Provider.State
	[Zip]                           VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.Zip
	[Phone]                         VARCHAR(50)       NULL,             -- FROM C8 alert.Provider.Phone
	[Location]                      VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Location

	-- Site
	[SiteId]                        NVARCHAR(MAX)     NULL,             -- FROM C8 alert.Provider.SiteId; open: how does it relate to cdxp.SiteProvider?

	-- Crosswalks (C8's manual ID corrections; keep only if alert.ApplyProviderCrosswalk is still run)
	[ProviderCrosswalkId]           UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Provider.ProviderCrosswalkId

	-- Load lineage
	[StagingRunId]                  UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Provider.StagingRunId

	-- Audit
	[InsertDate]                    DATETIME          NOT NULL,         -- NEW, CDXP audit pattern; FROM C8 alert.Provider.CreateDate DATETIME2
	[InsertedBy]                    NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]                   DATETIME          NOT NULL,         -- NEW, CDXP audit pattern; FROM C8 alert.Provider.UpdateDate DATETIME2
	[LastUpdatedBy]                 NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
