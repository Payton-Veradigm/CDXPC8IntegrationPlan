/*
    cdxp.BulkGapMedicationEvidence: medications that support a gap. Many to one with cdxp.BulkGap.

    CDXP: HPP's gap row carries one medication (Medication* fields), written into the FHIR bundle as a
          MedicationStatement or MedicationRequest. Marked FROM CDXP HPP row.<field>.
    C8:   no medication columns in alert.Detail. C8's report table alert.ProviderAlertFeedbackResponse has
          RxType, RxDesc, RxNCDName, RxNDC, RxGPI14, RxTherapeuticCategory, RxDosage, RxDaysSupply, RxQuantity, and
          RxLastFill. Open: are those evidence (belong here) or medication-adherence gap content (belong in BulkGapDetail)?

    The prescriber is a cdxp.BulkProvider row (found or created by NPI); the HPP row's
    MedicationPractitionerNpi, MedicationPractitionerFirstName, and MedicationPractitionerLastName land on that provider.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (../00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapMedicationEvidence] (
	-- Keys and partition
	[PayerPartitionKey]       SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[MedicationEvidenceKey]   BIGINT            IDENTITY(1, 1),   -- NEW
	[GapKey]                  BIGINT            NOT NULL,         -- NEW -> cdxp.BulkGap

	-- The medication
	[EffectiveDateTime]       DATETIME2         NULL,             -- FROM CDXP HPP row.MedicationEffectiveDateTime
	[MedicationCode]          VARCHAR(50)       NULL,             -- FROM CDXP HPP row.MedicationCode
	[MedicationCodeSystem]    VARCHAR(255)      NULL,             -- NEW: the code's FHIR coding system (NDC, RxNorm); HPP's row doesn't send one
	[MedicationDisplay]       VARCHAR(500)      NULL,             -- FROM CDXP HPP row.MedicationDisplay

	-- Who prescribed it
	[BulkProviderKey]         BIGINT            NULL,             -- NEW -> cdxp.BulkProvider
	[Organization]            VARCHAR(255)      NULL,             -- FROM CDXP HPP row.MedicationOrganization

	-- Load lineage
	[TrackerKey]              INT               NULL,             -- NEW: the CDXP run that sent it
	[StagingRunId]            UNIQUEIDENTIFIER  NULL,             -- NEW: the C8 staging run that sent it

	-- Audit
	[InsertDate]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]              NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]           NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);