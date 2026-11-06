/*
    cdxp.BulkGapAccess: the provider identifiers a gap is visible under, one row per gap and value. Many to one with
    cdxp.BulkGap. Provider SSO users see a gap when one of their identifiers matches a row here.

    Base:  alert.Mapping (C8, feature/pfa-refactor), keyed on the gap there and on the master record in Prod.
           CDXP has no equivalent.
    Built: after each load, per tenant and LOB, replacing that LOB's rows, the way alert.BuildMapping runs after each
           publish. Every open gap (in source, not expired) with an Attributed provider in cdxp.BulkProviderGap gets
           one row per distinct value:
             PROVIDER_ID          the Attributed row's PayerProviderId
             NPI                  the payer's record's NPI as sent (the provider table, on the gap's LOB and
                                  PayerProviderId, or ProviderKey for a payer that sends only NPIs)
             PROVIDER_TIN         that record's TIN
             GROUP_ID             that record's group ID and group name
             MED_CENTER           its med center
             RISK_CONTRACT_CLASS  its risk contract class
           When the member's GroupAttribOption is MemberDriven, the group, med center, and risk contract values come
           from cdxp.BulkMember instead (C8's alert.vw_GapProvider rule).

    The user's side stays in the Portal. SSO login rebuilds a user's ALERT_MAPPING rows in dbo.UserPermission, one per
    value, and users in a group with CanAccessAllAlerts skip the check. cdxp can't read the Portal database the way TRX
    does (dbo.vw_UserPermission), so the Portal passes the user's (AccessType, value) pairs, or all access, into
    CDXP's procedures. A match has to be in the gap's tenant and LOB.

    AccessType is the Portal's PermissionType.PermissionTypeName. GROUP_ID is fed by three SAML attributes (GroupID,
    ProviderGroupID, groupname), which is why its rows hold group names as well as IDs.

    Open:
      Closed gaps. C8 maps only open gaps, so providers can't see closed ones. Mapping them too would let Provider SSO
        users download inactive records, an open question in the 2026-10-30 provider feedback report draft.
      CDXP feeds don't send GroupAttribOption (it isn't in the V5.8 spec), so the load needs a tenant-and-LOB default,
        like C8's alert.LOBConfig.GroupAttribOption.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql). Reads look up
    (PayerPartitionKey, AccessType, AccessValue, LineOfBusinessKey) to find GapKey.
*/

CREATE TABLE [cdxp].[BulkGapAccess] (
	-- Keys and partition
	[PayerPartitionKey]   SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapAccessKey]        BIGINT            IDENTITY(1, 1),   -- NEW; C8 alert.Mapping.MappingId
	[GapKey]              BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap; FROM C8 alert.Mapping.DetailId
	[MemberKey]           BIGINT            NOT NULL,         -- NEW -> cdxp.BulkMember (the gap's member, repeated); FROM C8 alert.Mapping.AlertMemberId
	[LineOfBusinessKey]   TINYINT           NULL,             -- NEW: the gap's LOB, repeated for the lookup; FROM C8 alert.Mapping.LOB VARCHAR(10)

	-- The value
	[AccessType]          VARCHAR(100)      NOT NULL,         -- NEW: the Portal's PermissionType.PermissionTypeName; C8 stores alert.Mapping.PermissionTypeId, the GUID
	[AccessValue]         VARCHAR(100)      NOT NULL,         -- FROM C8 alert.Mapping.MappingKey

	-- Load lineage
	[TrackerKey]          INT               NULL,             -- NEW: the load that built the row; FROM C8 alert.Mapping.StagingRunId

	-- Audit
	[InsertDate]          DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]          NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]         DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]       NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);


[Tracker]

  [TrackerKey]
  [PayerKey]
  [CohortID] -- Only expire based on other IngestionSource trackers for the same payer
  -- Unique value, compared to payer-trackers with the same IngestionID for expiration