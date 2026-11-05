/*
    cdxp.BulkGapClinicalCode: the gap's codes, one row per code. Many to one with cdxp.BulkGap.

    Base:    CDXP's per-payer cdxp.<Payer>GapClinicalCode. PA-4 already builds this table with these columns (Ciep.AppService
             DevBranch, Schema/cdxp/Tables/Bulk/BulkGapClinicalCode.sql). PA-5's save fills it from each gap's Codes array.
    Laid in: no new columns. The code columns that moved out of cdxp.BulkGapDetail land here, and C8's codes the same way.

    CodeType is Measure or Diagnosis, the only two cdxp.GapModels allows:
      risk     a Measure row for the condition (CodeSystem the model, CodeVersion its version, CodeValue the HCC or
               other condition code) and a Diagnosis row for the ICD-10 code
      quality  a Measure row (CodeSystem NCQA, PQA, or VPI; CodeValue the measure code)
    The spec and C8 send one diagnosis per gap, so cdxp.BulkGapDetail.DateOfService describes the one Diagnosis row.
    The codes' descriptions are lookups: cdxp.DiagnosisCode for a Diagnosis row, cdxp.QualityMeasure for a quality
    Measure row, both on CodeSystem and CodeValue.

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
	[ClinicalCodeKey]    BIGINT            IDENTITY(1, 1),   -- FROM CDXP cdxp.<Payer>GapClinicalCode.ClinicalCodeKey
	[GapKey]             BIGINT            NOT NULL,         -- FROM CDXP cdxp.<Payer>GapClinicalCode.GapKey -> cdxp.BulkGap
	[MemberKey]          BIGINT            NULL,             -- FROM CDXP cdxp.<Payer>GapClinicalCode.MemberKey -> cdxp.BulkMember (the gap's member, repeated)

	-- The code
	[GapType]            VARCHAR(20)       NULL,             -- FROM CDXP cdxp.<Payer>GapClinicalCode.GapType: CI, CV, GIC, PatientSafety, MedicineAdherence, SDOH, EDU
	[CodeType]           VARCHAR(50)       NOT NULL,         -- FROM CDXP cdxp.<Payer>GapClinicalCode.CodeType: Measure or Diagnosis
	[CodeSystem]         VARCHAR(50)       NULL,             -- FROM CDXP bulk row.ModelName or MeasureNameModel; FROM C8 alert.HealthCodingModel.ModelBase or MeasureNameModel
	[CodeVersion]        VARCHAR(20)       NULL,             -- FROM CDXP bulk row.ModelNo; FROM C8 alert.HealthCodingModel.ModelVersion
	[CodeExtension]      VARCHAR(50)       NULL,             -- FROM CDXP the MeasureReport identifier with system .../identifier/CodeExtension (bulk row.Value)
	[CodeValue]          VARCHAR(50)       NULL,             -- FROM CDXP bulk row.ConditionCode, DiagnosisCode, or ShortMeasureName; FROM C8 ConditionCode, Diagnosis[0].CodeFormatted, or SourceMeasureId
	[CodeSignature]      AS (...) PERSISTED,                 -- FROM CDXP cdxp.<Payer>GapClinicalCode.CodeSignature: GapType|CodeType|CodeSystem|CodeVersion|CodeExtension|CodeValue|Period
	[GapModelKey]        INT               NULL,             -- FROM CDXP cdxp.<Payer>GapClinicalCode.GapModelKey -> cdxp.GapModels; NULL when no model matches

	-- Audit
	[InsertDate]         DATETIME          NOT NULL,         -- FROM CDXP cdxp.<Payer>GapClinicalCode.InsertDate
	[InsertedBy]         NVARCHAR(128)     NOT NULL,         -- FROM CDXP cdxp.<Payer>GapClinicalCode.InsertedBy
	[LastUpdated]        DATETIME          NOT NULL,         -- FROM CDXP cdxp.<Payer>GapClinicalCode.LastUpdated
	[LastUpdatedBy]      NVARCHAR(128)     NOT NULL          -- FROM CDXP cdxp.<Payer>GapClinicalCode.LastUpdatedBy
);
