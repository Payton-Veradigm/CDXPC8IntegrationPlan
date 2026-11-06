/*
    cdxp.ICDDiagCodeMapping: one row per risk model, condition and ICD-10 code, with the code's description and the
    condition's. The shared model reuses it as it is; only its loader changes. cdxp.vwDiagnosisCode, at the end, gives
    one row per ICD-10 code.

    Base:  CDXP's own table (Ciep.Proxy.Database, DevBranch). FetchDiagnosisCodeMappingsFunction loads it from
           Snowflake REF_DW_LEGACY.VW_ICD_DIAG_LOB_MAPPING for each active model in cdxp.GapModels with an
           SFCMSModelCode. VPI reads it through the FHIR Proxy's diagmapping endpoint. C8 loads the whole view into
           each tenant's alert.IcdDiagLobMapping (feature/pfa-refactor).
    Moved here from cdxp.BulkGapDetail: DiagnosisDescription.

    Lookup:
      a risk gap    its Measure row's GapModelKey and CodeValue match GapModelKey and RiskModelCondCode, and its
                    Diagnosis row's CodeValue matches ICDDxCode. Together that's this table's unique key. The
                    Diagnosis row's own GapModelKey is the ICD-10 model, which has no rows here.
      a code alone  cdxp.vwDiagnosisCode. cdxp.BulkGapDetail.FeedbackDiagnosisCode needs it: C8's PFA describes
                    the provider's feedback code from alert.IcdDiagLobMapping, on code and LOB.

    Loader change: load every model with an SFCMSModelCode, active or not, so V24-HCC (inactive in CDXP's seed) is
    here for older C8 gaps. spGetIcdDiagMapings, VPI's read, already returns only active models, so VPI doesn't change.

    Open:
      A code outside the loaded models has no description. ACG, DXCG, FRAILTY, ZCODEGROUP and VPI have no
        SFCMSModelCode. C8's report shows the payer's own text (DetailProperties Diagnosis[0].Description).
      The report's ConditionDescription is C8's DiseaseGroup: DISEASE_GROUP_TXT on C8's staging path, the HCC's name
        on its FHIR path. Check C8's values against RiskModelCondDesc and RiskModelMajorGroup.
      RiskModelCondCode's format against the gap's HCC code (18 or HCC18) isn't checked.
      Payers send ICD codes with or without the dot. ICDDxCode has no dot; ICDDxFormtCode has it.

    Pseudo-code: the table is CDXP's as it stands, with no constraints or indexes shown.
*/

CREATE TABLE [cdxp].[ICDDiagCodeMapping] (
	-- Keys
	[ICDDiagCodeMappingKey] BIGINT            IDENTITY(1, 1),   -- FROM CDXP
	[GapModelKey]           INT               NOT NULL,         -- FROM CDXP -> cdxp.GapModels: the risk model (V28-HCC, V08-ACA, CDPS, ...)

	-- The condition
	[RiskModelCondCode]     VARCHAR(200)      NULL,             -- FROM CDXP: the HCC or other condition code, as on the gap's Measure row
	[RiskModelCondDesc]     VARCHAR(MAX)      NULL,             -- FROM CDXP: the condition's description
	[RiskModelMajorGroup]   VARCHAR(500)      NULL,             -- FROM CDXP: the condition's major group
	[RiskModelCond]         VARCHAR(200)      NULL,             -- FROM CDXP: the loader overwrites the condition type with the code, so this repeats RiskModelCondCode

	-- The ICD-10 code
	[ICDDxCode]             VARCHAR(200)      NULL,             -- FROM CDXP: without the dot
	[ICDDxFormtCode]        VARCHAR(200)      NULL,             -- FROM CDXP: with the dot
	[ICDDxDesc]             VARCHAR(MAX)      NULL,             -- FROM CDXP: replaces cdxp.BulkGapDetail.DiagnosisDescription

	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- FROM CDXP
	[InsertedBy]            NVARCHAR(128)     NOT NULL,         -- FROM CDXP
	[LastUpdated]           DATETIME          NOT NULL,         -- FROM CDXP
	[LastUpdatedBy]         NVARCHAR(128)     NOT NULL          -- FROM CDXP
);
GO

-- NEW: one row per ICD-10 code
CREATE VIEW [cdxp].[vwDiagnosisCode] AS
SELECT [ICDDxCode], [ICDDxFormtCode], [ICDDxDesc]
FROM (
	SELECT [ICDDxCode], [ICDDxFormtCode], [ICDDxDesc],
	       ROW_NUMBER() OVER (PARTITION BY [ICDDxCode] ORDER BY [LastUpdated] DESC) AS [RowNumber]
	FROM [cdxp].[ICDDiagCodeMapping]
) AS [Mapping]
WHERE [RowNumber] = 1;
