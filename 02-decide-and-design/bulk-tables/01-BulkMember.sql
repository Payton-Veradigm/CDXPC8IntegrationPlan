/*
    cdxp.BulkMember: one row per payer member.

    Base:    CDXP's per-payer member table, cdxp.<Payer>Member, which PA-4 consolidates as cdxp.BulkMember.
    Laid in: every column of alert.Member (C8), marked FROM C8. A column both products have appears once.

    Pseudo-code: no constraints or indexes. Every Bulk* table is partitioned on PayerPartitionKey (00-PayerPartition.sql).
    PHI is shown as CDXP stores it (encrypted VARBINARY), pending the PHI decision (notes/phi-model.md). The comment gives C8's plain type.
    Not carried: alert.Member.MemberName, a computed "LastName, FirstName". Build it on read.
*/

CREATE TABLE [cdxp].[BulkMember] (
	-- Keys and partition
	[PayerPartitionKey]           SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[MemberKey]                   BIGINT            IDENTITY(1, 1),   -- FROM CDXP cdxp.<Payer>Member.MemberKey
	[AlertMemberId]               UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Member.AlertMemberId (TRX PK; FHIR Patient.Id)
	[LineOfBusinessKey]           TINYINT           NULL,             -- FROM C8 alert.Member.LOB VARCHAR(10), mapped to cdxp.LineOfBusiness; CDXP keeps LOB on the gap only
	-- A member can have gaps form multiple LOBs, correct?

	-- Member identifiers (PHI)
	[MemberID]                    VARBINARY(256)    NOT NULL,         -- FROM CDXP cdxp.<Payer>Member.MemberID; FROM C8 alert.Member.MemberId VARCHAR(50)
	[UniqueMemberID]              VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.UniqueMemberID (NOT NULL there; C8 has no equivalent)
	[PlanMemberId]                VARBINARY(256)    NULL,             -- FROM C8 alert.Member.PlanMemberId VARCHAR(50); the bulk row sends both UNIQUE_MEMBER_ID and PLAN_MEMBER_ID
	[MRN]                         VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.MRN; FROM C8 alert.Member.MRN VARCHAR(50)
	[GovernmentId]                VARBINARY(256)    NULL,             -- FROM C8 alert.Member.Government_ID VARCHAR(100)

	-- Demographics (PHI)
	[LastName]                    VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.LastName; FROM C8 alert.Member.LastName NVARCHAR(45)
	[FirstName]                   VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.FirstName; FROM C8 alert.Member.FirstName NVARCHAR(45)
	[DateOfBirth]                 VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.DateOfBirth; FROM C8 alert.Member.DOB DATE
	[Gender]                      VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.Gender; FROM C8 alert.Member.Gender VARCHAR(1)
	[Zip5]                        VARBINARY(256)    NULL,             -- FROM CDXP cdxp.<Payer>Member.Zip5; for C8, the first five digits of alert.Member.ZipCode
	[ZipCode]                     VARBINARY(256)    NULL,             -- FROM C8 alert.Member.ZipCode VARCHAR(10), ZIP+4 when sent
	[Address]                     VARBINARY(256)    NULL,             -- FROM C8 alert.Member.Address NVARCHAR(45)
	[City]                        VARBINARY(256)    NULL,             -- FROM C8 alert.Member.City NVARCHAR(45)
	[State]                       NVARCHAR(2)       NULL,             -- FROM C8 alert.Member.State
	[Phone]                       VARBINARY(256)    NULL,             -- FROM C8 alert.Member.Phone NVARCHAR(25)
	[IsDeceased]                  BIT               NULL,             -- FROM C8 alert.Member.IsDeceased (feature/pfa-refactor; NOT NULL DEFAULT 0 there)
	[DeceasedDate]                VARBINARY(256)    NULL,             -- FROM C8 alert.Member.DeceasedDate DATE (feature/pfa-refactor)

	-- Matching (CDXP)
	[LNameDOBHash]                BIGINT            NULL,             -- FROM CDXP cdxp.<Payer>Member.LNameDOBHash
	[RowKey]                      BIGINT            NOT NULL,         -- FROM CDXP cdxp.<Payer>Member.RowKey

	-- PCP attribution and visits
	[PCPId]                       VARCHAR(100)      NULL,             -- FROM C8 alert.Member.PCPId (NOT NULL in C8); the payer's provider ID, see cdxp.PayerProvider.PayerProviderId
	[PCPLastVisitDate]            VARCHAR(20)       NULL,             -- FROM C8 alert.Member.PCPLastVisitDate
	[PCPAttribLastVisitDate]      VARCHAR(10)       NULL,             -- FROM C8 alert.Member.PCPAttribLastVisitDate
	[MaMaxPCPAttribLastVisitDate] VARCHAR(10)       NULL,             -- FROM C8 alert.Member.MaMaxPCPAttribLastVisitDate
	[PCPAttribNumVisits]          INT               NULL,             -- FROM C8 alert.Member.PCPAttribNumVisits
	[AWV_Last_Date]               DATE              NULL,             -- FROM C8 alert.Member.AWV_Last_Date
	[AWV_ProviderID]              VARCHAR(100)      NULL,             -- FROM C8 alert.Member.AWV_ProviderID
	[Preventive_LastDate]         DATE              NULL,             -- FROM C8 alert.Member.Preventive_LastDate
	[Preventive_ProviderID]       VARCHAR(100)      NULL,             -- FROM C8 alert.Member.Preventive_ProviderID

	-- Plan and enrollment
	[IsTermed]                    BIT               NULL,             -- FROM C8 alert.Member.IsTermed
	[MetalLevel]                  VARCHAR(45)       NULL,             -- FROM C8 alert.Member.MetalLevel
	[PBP]                         VARCHAR(3)        NULL,             -- FROM C8 alert.Member.PBP
	[Market]                      VARCHAR(50)       NULL,             -- FROM C8 alert.Member.Market
	[PlanAttribute1]              NVARCHAR(100)     NULL,             -- FROM C8 alert.Member.PlanAttribute1
	[PlanAttribute2]              NVARCHAR(100)     NULL,             -- FROM C8 alert.Member.PlanAttribute2
	[PlanAttribute3]              NVARCHAR(100)     NULL,             -- FROM C8 alert.Member.PlanAttribute3
	[ModelDetail]                 VARCHAR(45)       NULL,             -- FROM C8 alert.Member.ModelDetail

	-- Org hierarchy and contracts (drive C8 access mapping and reports)
	[GroupID]                     VARCHAR(100)      NULL,             -- FROM C8 alert.Member.GroupID
	[GroupName]                   VARCHAR(150)      NULL,             -- FROM C8 alert.Member.GroupName
	[SuperGroupID]                VARCHAR(100)      NULL,             -- FROM C8 alert.Member.SuperGroupID
	[SuperGroupName]              VARCHAR(150)      NULL,             -- FROM C8 alert.Member.SuperGroupName
	[MedCenter]                   VARCHAR(100)      NULL,             -- FROM C8 alert.Member.MedCenter
	[MedCenterDesc]               VARCHAR(150)      NULL,             -- FROM C8 alert.Member.MedCenterDesc
	[SettlementEntityID]          VARCHAR(100)      NULL,             -- FROM C8 alert.Member.SettlementEntityID
	[SettlementEntityName]        VARCHAR(150)      NULL,             -- FROM C8 alert.Member.SettlementEntityName
	[GroupAttribOption]           VARCHAR(200)      NULL,             -- FROM C8 alert.Member.GroupAttribOption: MemberDriven puts these, not the gap provider's, in cdxp.BulkGapAccess; CDXP feeds need a tenant-and-LOB default
	[Risk_Contract_ID]            VARCHAR(100)      NULL,             -- FROM C8 alert.Member.Risk_Contract_ID
	[Risk_Contract_Group]         VARCHAR(100)      NULL,             -- FROM C8 alert.Member.Risk_Contract_Group
	[Risk_Contract_Class]         VARCHAR(100)      NULL,             -- FROM C8 alert.Member.Risk_Contract_Class

	-- Risk metrics
	[LastPMRRDate]                DATETIME2         NULL,             -- FROM C8 alert.Member.LastPMRRDate
	[TotalPARAFImpact]            DECIMAL(10, 3)    NULL,             -- FROM C8 alert.Member.TotalPARAFImpact

	-- Crosswalks (C8's manual ID corrections; keep only if alert.ApplyMemberCrosswalk / ApplyProviderCrosswalk are still run)
	[MemberCrosswalkId]           UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Member.MemberCrosswalkId
	[ProviderCrosswalkId]         UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Member.ProviderCrosswalkId

	-- Delivery (CDXP)
	[PayerPathDeltaGapCount]      INT               NULL,             -- FROM CDXP cdxp.<Payer>Member.PayerPathDeltaGapCount

	-- Load lineage: C8 staging runs, kept while RAA's imports into CDXP still run as staging runs
	[FirstStagingRunId]           UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Member.FirstStagingRunId: the run that first loaded the member
	[LastStagingRunId]            UNIQUEIDENTIFIER  NULL,             -- FROM C8 alert.Member.LastStagingRunId: the current run, the latest that loaded it

	-- Audit
	[InsertDate]                  DATETIME          NOT NULL,         -- FROM CDXP cdxp.<Payer>Member.InsertDate; FROM C8 alert.Member.CreateDate DATETIME2
	[InsertedBy]                  NVARCHAR(128)     NOT NULL,         -- FROM CDXP cdxp.<Payer>Member.InsertedBy
	[LastUpdated]                 DATETIME          NOT NULL,         -- FROM CDXP cdxp.<Payer>Member.LastUpdated; FROM C8 alert.Member.UpdateDate DATETIME2
	[LastUpdatedBy]               NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.<Payer>Member.LastUpdatedBy
);
