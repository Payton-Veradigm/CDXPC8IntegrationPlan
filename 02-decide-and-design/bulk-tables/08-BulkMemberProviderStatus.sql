/*
    cdxp.BulkMemberProviderStatus: what a practice asserts about a member, today only "not seen here".
    Many to one with cdxp.BulkMember. Every assertion is kept; IsCurrent marks the latest per member and provider.

    Base:     alert.MemberProviderStatus (C8, feature/pfa-refactor). CDXP has no equivalent.
    Replaces: its history table, alert.MemberProviderStatusHistory. A change is a new row, as in cdxp.BulkGapFeedback.

    "Not seen here" is one practice's claim, so it's keyed on the provider as well as the member. C8 keys it on the
    payer's provider ID, so two payer IDs under one NPI keep separate rows.
    alert.vw_GapStatus counts a gap as Responded when its member is Not Seen Here for the gap's provider, and the
    provider feedback report draft shows it as the gap's feedback ("Patient Not Seen Here").

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkMemberProviderStatus] (
	-- Keys and partition
	[PayerPartitionKey]        SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[MemberProviderStatusKey]  BIGINT            IDENTITY(1, 1),   -- NEW; C8 keys on a sequential GUID, MemberProviderStatusId
	[MemberKey]                BIGINT            NOT NULL,         -- NEW -> cdxp.BulkMember; FROM C8 alert.MemberProviderStatus.AlertMemberId
	[ProviderKey]              BIGINT            NULL,             -- NEW -> cdxp.Provider: the NPI of the provider below; NULL when it has none
	[PayerProviderId]          VARCHAR(100)      NOT NULL,         -- FROM C8 alert.MemberProviderStatus.ProviderId; with the member's LOB it finds cdxp.PayerProvider

	-- The assertion
	[IsNotSeenHere]            BIT               NOT NULL,         -- FROM C8 alert.MemberProviderStatus.IsNotSeenHere
	[NotSeenHereDate]          DATE              NULL,             -- FROM C8 alert.MemberProviderStatus.NotSeenHereDate: when the practice asserted it
	[StatusUser]               NVARCHAR(450)     NULL,             -- FROM C8 alert.MemberProviderStatus.CreatedById, or ModifiedById for a change: the app user

	-- State
	[IsCurrent]                BIT               NOT NULL,         -- NEW: the latest assertion for this member and provider

	-- Audit
	[InsertDate]               DATETIME          NOT NULL,         -- NEW, CDXP audit pattern; FROM C8 CreatedDate, or ModifiedDate for a change
	[InsertedBy]               NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]            NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
