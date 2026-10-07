# Decide how a gap is identified

[Back to steps](../steps.md)

- **Proposal:**
  - **Business key:** tenant, member, detail code, detail type, and program year. This is the live-gap rule on Collaborate's gap-centric branch (`jk/pfa-refactor`), plus the tenant.
  - **Platform gap ID:** one `BIGINT` ID that both products use and send to partners.
  - **Payer's gap ID:** kept as an attribute, widened from Collaborate's 60 characters to CDXP's 150.
  - **Soft closure:** looks up by the platform ID or the payer's gap ID only.
- **Old IDs:** TRX's INT IDs (`DetailId`, `MasterId`, `DocumentId`) repeat across customers. Either keep them, paired with the tenant, through the transition, or mint new keys with a crosswalk.
- **Open:**
  - Which period identifies a gap that has no program year, such as a risk gap?
  - CDXP requires a payer's gap ID to be unique across all years, while Collaborate's identity is per year. Do payer gap IDs ever repeat across years?
  - Some CDXP gap IDs are actually Collaborate `DetailId`s.
  - Bug #161773 (FHIR Publish sends the internal ID instead of the partner ID for some OTB gaps) is still Active.
- **Hazard today:** Collaborate matches a numeric gap ID against `DetailId` first, so feedback can land on the wrong gap.
