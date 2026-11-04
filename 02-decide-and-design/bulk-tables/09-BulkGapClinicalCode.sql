/*
    cdxp.BulkGapClinicalCode: the gap's codes, one row per code. Many to one with cdxp.BulkGap.

    Base:    cdxp.HPPGapClinicalCode (CDXP). PA-4 already builds this table with these columns (Ciep.AppService
             DevBranch, Schema/cdxp/Tables/Bulk/BulkGapClinicalCode.sql). PA-5's save fills it from each gap's Codes array.
    Laid in: no new columns. The code columns that moved out of cdxp.BulkGapDetail land here, and C8's codes the same way.

    CodeType is Measure or Diagnosis, the only two cdxp.GapModels allows:
      risk     a Measure row for the condition (CodeSystem the model, CodeVersion its version, CodeValue the HCC or
               other condition code) and a Diagnosis row for the ICD-10 code
      quality  a Measure row (CodeSystem NCQA, PQA, or VPI; CodeValue the measure code)
    The spec and C8 send one diagnosis per gap, so cdxp.BulkGapDetail.DiagnosisDescription and DateOfService describe
    the one Diagnosis row.

    PA-4 makes a code unique per gap on (GapKey, GapType, CodeType, CodeSystem, CodeExtension, CodeValue) when
    CodeSystem and CodeValue are set. When the point of care asks for a patient's gaps, cdxp.spGetBulkGaps returns
    each gap's latest Measure row and whether it has a Diagnosis row.

    Open:
      CodeSystem must use cdxp.GapModels' names (CMSHCC, NCQA, ...): PA-5 links a model only on an exact match.
        C8's models come from Portal's alert.HealthCodingModel and need mapping to those names. Unmatched codes are
        still saved, with no GapModelKey.
      CodeValue allows 50 characters. C8's DetailCode, which holds SourceMeasureId for quality gaps, allows 200.
      PA-5 treats GapType SDOHINSIGHT as risk, but CDXP's code rows use SDOH.

    Pseudo-code: no constraints or indexes. Partitioned on PayerPartitionKey (00-PayerPartition.sql).
*/

CREATE TABLE [cdxp].[BulkGapClinicalCode] (
	-- Keys and partition
	[PayerPartitionKey]  SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[ClinicalCodeKey]    BIGINT            IDENTITY(1, 1),   -- FROM CDXP cdxp.HPPGapClinicalCode.ClinicalCodeKey
	[GapKey]             BIGINT            NOT NULL,         -- FROM CDXP cdxp.HPPGapClinicalCode.GapKey -> cdxp.BulkGap
	[MemberKey]          BIGINT            NULL,             -- FROM CDXP cdxp.HPPGapClinicalCode.MemberKey -> cdxp.BulkMember (the gap's member, repeated)

	-- The code
	[GapType]            VARCHAR(20)       NULL,             -- FROM CDXP cdxp.HPPGapClinicalCode.GapType: CI, CV, GIC, PatientSafety, MedicineAdherence, SDOH, EDU
	[CodeType]           VARCHAR(50)       NOT NULL,         -- FROM CDXP cdxp.HPPGapClinicalCode.CodeType: Measure or Diagnosis
	[CodeSystem]         VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ModelName or MeasureNameModel; FROM C8 alert.HealthCodingModel.ModelBase or MeasureNameModel
	[CodeVersion]        VARCHAR(20)       NULL,             -- FROM CDXP HPP row.ModelNo; FROM C8 alert.HealthCodingModel.ModelVersion
	[CodeExtension]      VARCHAR(50)       NULL,             -- FROM CDXP the MeasureReport identifier with system .../identifier/CodeExtension (HPP row.Value)
	[CodeValue]          VARCHAR(50)       NULL,             -- FROM CDXP HPP row.ConditionCode, DiagnosisCode, or ShortMeasureName; FROM C8 ConditionCode, Diagnosis[0].CodeFormatted, or SourceMeasureId
	[CodeSignature]      AS (...) PERSISTED,                 -- FROM CDXP cdxp.HPPGapClinicalCode.CodeSignature: GapType|CodeType|CodeSystem|CodeVersion|CodeExtension|CodeValue
	[GapModelKey]        INT               NULL,             -- FROM CDXP cdxp.HPPGapClinicalCode.GapModelKey -> cdxp.GapModels; NULL when no model matches

	-- Audit
	[InsertDate]         DATETIME          NOT NULL,         -- FROM CDXP cdxp.HPPGapClinicalCode.InsertDate
	[InsertedBy]         NVARCHAR(128)     NOT NULL,         -- FROM CDXP cdxp.HPPGapClinicalCode.InsertedBy
	[LastUpdated]        DATETIME          NOT NULL,         -- FROM CDXP cdxp.HPPGapClinicalCode.LastUpdated
	[LastUpdatedBy]      NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.HPPGapClinicalCode.LastUpdatedBy
);
