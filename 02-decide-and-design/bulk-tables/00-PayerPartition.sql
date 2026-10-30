/*
    Payer partitioning for the cdxp.Bulk* tables.

    Every Bulk* table leads with PayerPartitionKey and is stored on psPartitionByPayerKey,
    the way the site-scoped tables use SitePartitionKey and psPartitionBySiteKey.

    PayerPartitionKey = cdxp.Payer.PayerKey (SMALLINT). A Collaborate-only customer gets its own cdxp.Payer row.
    Partitions are added before a payer is onboarded (CIEP #169995 pattern).

    Sources:
      CDXP  C:\cdxp DevBranch 67a432cc3 (2026-10-26); cdxp.Provider from PR 53441 (BrandonDev_ProviderNPI_Split_Release2)
      C8    C:\C8DB release/2026.06.01, _Template_TRX/alert/Tables
*/

CREATE PARTITION FUNCTION [pfPartitionByPayerKey](SMALLINT)
AS
	RANGE RIGHT FOR VALUES (1, 2, 3 /* , ... one boundary per cdxp.Payer.PayerKey */);
GO

CREATE PARTITION SCHEME [psPartitionByPayerKey]
AS
	PARTITION [pfPartitionByPayerKey] ALL TO ([PRIMARY]);
GO

