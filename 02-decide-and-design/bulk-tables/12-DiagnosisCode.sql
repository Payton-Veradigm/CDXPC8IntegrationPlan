/*
    cdxp.DiagnosisCode: one row per ICD-10 code, with its description. A gap reaches it through its Diagnosis row in
    cdxp.BulkGapClinicalCode, on CodeSystem and on CodeValue without the dot: payers send codes either way, and C8
    sends them formatted.

    Base:  C8's alert.IcdDiagLobMapping (TRX), which also maps each code to its HCC and that HCC's description, by CMS
           model and LOB. CDXP has none; its bulk row sends a description with every gap.
    Moved here from cdxp.BulkGapDetail: DiagnosisDescription.

    Reference data like cdxp.GapModels, so not partitioned or per payer.

    Open: payers send their own description text, which can differ from the standard one. Keep one per code?

    Pseudo-code: no constraints or indexes.
*/

CREATE TABLE [cdxp].[DiagnosisCode] (
	-- Keys
	[DiagnosisCodeKey]      INT               IDENTITY(1, 1),   -- NEW
	[CodeSystem]            VARCHAR(50)       NOT NULL,         -- NEW: ICD-10, as on the Diagnosis row in cdxp.BulkGapClinicalCode
	[CodeValue]             VARCHAR(10)       NOT NULL,         -- FROM C8 alert.IcdDiagLobMapping.IcdDiagnosisCode: the code without the dot

	-- The code
	[FormattedCode]         VARCHAR(16)       NULL,             -- FROM C8 alert.IcdDiagLobMapping.IcdDiagnosisFormattedCode: with the dot
	[Description]           NVARCHAR(500)     NULL,             -- FROM C8 alert.IcdDiagLobMapping.IcdDiagnosisDescription; FROM CDXP bulk row.DiagnosisDescription
	-- CDXP already has this, look to reuse that




	-- Audit
	[InsertDate]            DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]            NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]           DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]         NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
