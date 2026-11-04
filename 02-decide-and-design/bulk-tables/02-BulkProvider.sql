/*
    cdxp.BulkProvider: the payer's provider records (PCPs, attributed providers, responders).

    Base:    cdxp.Provider as reshaped by PR 53441 (BrandonDev_ProviderNPI_Split_Release2, Brandon Schroeder),
             which makes cdxp.Provider global: one row per NPI, with name and taxonomy classification.
    Laid in: every column of alert.Provider (C8), marked FROM C8.

    BulkProvider is payer-scoped and points at the global cdxp.Provider row through ProviderKey.
    Open: keep the classification group here, or read it from cdxp.Provider and drop it.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkProvider] (
	-- Keys and partition
	[PayerPartitionKey]             SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[BulkProviderKey]               BIGINT            IDENTITY(1, 1),   -- NEW, modeled on cdxp.Provider.ProviderKey
	[ProviderKey]                   BIGINT            NULL,             -- NEW: the global cdxp.Provider row for this NPI; NULL when the payer sent no NPI
	[LineOfBusinessKey]             TINYINT           NULL,             -- FROM C8 alert.Provider.LOB VARCHAR(10); part of C8's unique key (LOB, ProviderId), which finds the gap's provider

	-- Provider identifiers
	[PayerProviderId]               VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.ProviderId (NOT NULL in C8); alert.Member.PCPId points at it
	[NPI]                           BIGINT            NULL,             -- FROM CDXP cdxp.Provider.NPI (NOT NULL there); FROM C8 alert.Provider.NPI VARCHAR(45)
	[TIN]                           VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.TIN; FROM CDXP the V5.8 spec's TIN, recorded at ingestion
	-- The PROVIDER_TIN access key (cdxp.BulkGapAccess) matches this TIN, one per provider record, so no separate TIN
	-- table is needed. CDXP's site TIN (Provider -> ProviderSite -> Site -> SiteTin) is a different value.

	-- Name
	[ProviderName]                  VARCHAR(255)      NULL,             -- FROM CDXP cdxp.Provider.ProviderName; C8 computes alert.Provider.ProviderName as "LastName, FirstName"
	[FirstName]                     NVARCHAR(45)      NULL,             -- FROM C8 alert.Provider.FirstName
	[LastName]                      NVARCHAR(255)     NULL,             -- FROM C8 alert.Provider.LastName

	-- Specialty and classification
	[PracticeSpecialityTaxonomyKey] INT               NULL,             -- FROM CDXP cdxp.Provider.PracticeSpecialityTaxonomyKey
	[IsPrimaryCare]                 BIT               NULL,             -- FROM CDXP cdxp.Provider.IsPrimaryCare
	[TaxonomyClassificationStatus]  VARCHAR(50)       NULL,             -- FROM CDXP cdxp.Provider.TaxonomyClassificationStatus
	[LastClassifiedDate]            DATETIME          NULL,             -- FROM CDXP cdxp.Provider.LastClassifiedDate
	[SpecCode]                      VARCHAR(45)       NULL,             -- FROM C8 alert.Provider.SpecCode (payer's specialty code, not a taxonomy)
	[SpecDesc]                      VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SpecDesc

	-- Org hierarchy and contracts (drive C8 access mapping and reports)
	[GroupId]                       VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.GroupId
	[GroupName]                     VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.GroupName
	[SuperGroupID]                  VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SuperGroupID
	[SuperGroupName]                VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.SuperGroupName
	[MedCenter]                     VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.MedCenter
	[MedCenterDesc]                 VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.MedCenterDesc
	[SettlementEntityID]            VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.SettlementEntityID
	[SettlementEntityName]          VARCHAR(150)      NULL,             -- FROM C8 alert.Provider.SettlementEntityName
	[Risk_Contract_ID]              VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_ID
	[Risk_Contract_Group]           VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_Group
	[Risk_Contract_Class]           VARCHAR(100)      NULL,             -- FROM C8 alert.Provider.Risk_Contract_Class

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
	[InsertDate]                    DATETIME          NOT NULL,         -- FROM CDXP cdxp.Provider.InsertDate; FROM C8 alert.Provider.CreateDate DATETIME2
	[InsertedBy]                    NVARCHAR(128)     NOT NULL,         -- FROM CDXP cdxp.Provider.InsertedBy
	[LastUpdated]                   DATETIME          NOT NULL,         -- FROM CDXP cdxp.Provider.LastUpdated; FROM C8 alert.Provider.UpdateDate DATETIME2
	[LastUpdatedBy]                 NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.Provider.LastUpdatedBy
);
