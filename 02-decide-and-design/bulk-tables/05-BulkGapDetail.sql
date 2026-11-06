/*
    cdxp.BulkGapDetail: the gap's own content and its one feedback response. One row per gap (1:1 with cdxp.BulkGap).

    CDXP: only inside the FHIR bundle today (<Payer>Gap.FileLocation). Fields marked FROM CDXP bulk row.<field>
          come from the bulk gap row CDXP's flat-file formatters read, which the V5.8 spec now defines.
    C8:   alert.Detail.DetailProperties, a JSON column.

    Elsewhere:
      member and provider fields                          -> cdxp.BulkMember and the provider tables
      period, gap type, LOB and partner gap ID            -> cdxp.BulkGap
      the gap's codes                                     -> cdxp.BulkGapClinicalCode
      measure name, short name, description, category,
        call to action and improvement notation           -> cdxp.CTADiagCodeMapping, by the gap's Measure code
      diagnosis and condition descriptions                -> cdxp.ICDDiagCodeMapping, by the gap's Measure and Diagnosis codes
      evidence, including the bulk row's BasicText notes  -> blob storage only

    Feedback: one set of columns that the PFA, EHRs, and payers all write (decided 2026-11-05, Payton Obrycki).
    It replaces:
      C8    alert.Detail's PFA set (Feedback, FeedbackDate, FeedbackSourceId, FeedbackNpi, FeedbackDiagnosisCode,
            FeedbackUser, FeedbackSelectedBy) and its external set (ExternalFeedback, ExternalFeedbackNotes,
            ExternalFeedbackDate, ExternalSourceId). C8's VIM uploads write both sets today.
      CDXP  the point-of-care response on cdxp.Gap (FeedBackTypeKey, FeedbackDate, ProviderNPIKey, ClaimID,
            ResponseSubStatus, GapComment, FeedbackFileLocation)
    Member-level answers stay off the gap: deceased is on cdxp.BulkMember, and Not Seen Here is
    cdxp.BulkMemberProviderStatus. Both still outrank the gap's response, as in C8's alert.vw_GapReportedAnswer.

    Open:
      C8's Rx gaps keep their medication fields (NDC, GPI14, dosage, days supply, quantity, last fill) in
        DetailProperties. If they're gap content, they need columns here.
      With one response, a later answer replaces an earlier one. C8 keeps a PFA and an EHR answer at once today,
        alert.vw_GapReportedAnswer ranks the PFA's first, and FeedbackSelectedBy stays EHR once an EHR answers
        first. Keep either rule?
      Replaced responses: C8 copies each to alert.FeedbackHistory, and only a one-time backfill script reads it.
        Log them in cdxp.BulkGapAuditLog, or keep none?
      Which EHR answered: C8's ExternalSourceId (VIM Bulk, Veradigm Pro, Practice Fusion, Epic, Athena, NextGen) has
        no column now. FeedbackTargetAppKey can hold it if cdxp.TargetApp gets rows for the EHRs it lacks.
      FeedbackOrigin follows from FeedbackTargetAppKey once cdxp.TargetApp has a PFA row. Drop it then?
      Merge C8's per-tenant alert.FeedbackType (limited per gap type by alert.DetailType_FeedbackType) with CDXP's
        global cdxp.FeedBackType.

    Pseudo-code: no constraints or indexes. Types and lengths are proposals.
*/

CREATE TABLE [cdxp].[BulkGapDetail] (
	-- Keys and partition
	[PayerPartitionKey]       SMALLINT          NOT NULL,         -- NEW: cdxp.Payer.PayerKey
	[GapKey]                  BIGINT            NOT NULL,         -- NEW: 1:1 with cdxp.BulkGap

	-- Gap definition
	[IdSource]                VARCHAR(50)       NULL,             -- FROM CDXP bulk row.IdSource
	[EpisodeDate]             DATE              NULL,             -- FROM CDXP bulk row.EpisodeDate
	[DateOfService]           DATE              NULL,             -- FROM CDXP bulk row.Dos
	[AdditionalFlexFileName]  VARCHAR(255)      NULL,             -- FROM CDXP bulk row.AdditionalFlexFileName

	-- Quality measure (its names, description, category, call to action and improvement notation are in cdxp.CTADiagCodeMapping)
	[StatusDescription]       VARCHAR(255)      NULL,             -- FROM CDXP bulk row.StatusDescription (non-compliant or compliant)
	[Notes]                   VARCHAR(500)      NULL,             -- FROM C8 DetailProperties.Notes; not the bulk row's BasicText, which is evidence
	-- Look at the values in C8 db

	-- Risk condition (the diagnosis and condition descriptions are in cdxp.ICDDiagCodeMapping)
	[ConfidenceLevel]         VARCHAR(50)       NULL,             -- FROM CDXP bulk row.ConfidenceLevel
	[RafImpact]               DECIMAL(10, 3)    NULL,             -- FROM CDXP bulk row.RafImpact
	[FactoredRafImpact]       DECIMAL(10, 3)    NULL,             -- FROM C8 DetailProperties.FactoredRAFImpact
	[FinancialImpact]         DECIMAL(12, 2)    NULL,             -- FROM C8 DetailProperties.FinancialImpact
	[FactoredFinancialImpact] DECIMAL(12, 2)    NULL,             -- FROM C8 DetailProperties.FactoredFinancialImpact

	-- Reporting organization
	[ReportingOrganization]   VARCHAR(255)      NULL,             -- FROM CDXP bulk row.ReportingOrganization

	-- Feedback: the response
	[FeedbackTypeKey]         INT               NULL,             -- FROM C8 alert.Detail.Feedback (-> alert.FeedbackType) and alert.Detail.ExternalFeedback VARCHAR(100); FROM CDXP cdxp.Gap.FeedBackTypeKey (-> cdxp.FeedBackType)
	[FeedbackDate]            DATETIME2         NULL,             -- FROM C8 alert.Detail.FeedbackDate / alert.Detail.ExternalFeedbackDate; FROM CDXP cdxp.Gap.FeedbackDate
	[FeedbackDiagnosisCode]   VARCHAR(30)       NULL,             -- FROM C8 alert.Detail.FeedbackDiagnosisCode; described by cdxp.vwDiagnosisCode
	[FeedbackClaimId]         VARCHAR(100)      NULL,             -- FROM CDXP cdxp.Gap.ClaimID
	[FeedbackSubStatus]       VARCHAR(500)      NULL,             -- FROM CDXP cdxp.Gap.ResponseSubStatus
	[FeedbackNotes]           VARCHAR(MAX)      NULL,             -- FROM C8 alert.Detail.ExternalFeedbackNotes, where VIM uploads put their stage ID; FROM CDXP cdxp.Gap.GapComment

	-- Feedback: where it came from
	[FeedbackOrigin]          VARCHAR(50)       NULL,             -- FROM C8 alert.FeedbackSource.FeedbackBrokerName via alert.Detail.FeedbackSourceId (PFA, CDXP, VIM Bulk)
	-- EHR
	[FeedbackTargetAppKey]    TINYINT           NULL,             -- NEW -> cdxp.TargetApp (VPI, Athena MOC, VIM, VPI Overlay); FROM C8 alert.Detail.FeedbackSourceId -> alert.FeedbackSource
	-- Add a value for PFA, records which front-end feedback came from

	-- Feedback: who responded
	[FeedbackProviderKey]     BIGINT            NULL,             -- NEW -> cdxp.Provider; FROM CDXP cdxp.Gap.ProviderNPIKey; FROM C8 alert.Detail.FeedbackNpi VARCHAR(45) (resolved by NPI)
	[FeedbackUserId]          NVARCHAR(450)     NULL,             -- FROM C8 alert.Detail.FeedbackSelectedBy: the PFA user's AspNetUsers.Id; NULL where C8 writes EHR or BULK
	[FeedbackUser]            NVARCHAR(256)     NULL,             -- FROM C8 alert.Detail.FeedbackUser: the PFA user's username
	[FeedbackUserFullName]    NVARCHAR(256)     NULL,             -- NEW: the responder's full name, saved with the response; C8 keeps only the username

	-- Feedback: content pointer
	[FeedbackFileLocation]    VARCHAR(500)      NULL,             -- FROM CDXP cdxp.Gap.FeedbackFileLocation; goes away once content lives in SQL

	-- Audit
	[InsertDate]              DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[InsertedBy]              NVARCHAR(128)     NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdated]             DATETIME          NOT NULL,         -- NEW, CDXP audit pattern
	[LastUpdatedBy]           NVARCHAR(128)     NOT NULL          -- NEW, CDXP audit pattern
);
