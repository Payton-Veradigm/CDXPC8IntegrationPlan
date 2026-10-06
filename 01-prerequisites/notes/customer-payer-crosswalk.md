# Map Collaborate customers to CDXP payers

[Back to steps](../steps.md)

- **Why:** the tenant key needs one entry per customer or payer, and names don't match across the products.
- **Join today:** Collaborate's `VeradigmPayerId` equals CDXP's `GlobalPayerID`.
- **Name mismatches (Collaborate / CDXP):**
  - BCBSMichigan / BCBSMI.
  - CommunityCareOK / CCOK.
  - ChristusHealth / Christus.
  - Horizon / BCBSHorizon. Deployed CDXP environments also call this payer "Horizon".
- **For each row, record:**
  - Both IDs and both names.
  - Its LOBs.
  - Which products serve it (PFA, VPI).
  - CDXP's Hybrid and MP flags in each environment.
- **Known:** the VPI customers, which both products serve, are BCBS MI, CCOK, Christus, and Horizon.
- **Open:**
  - Are Admirian and Xanthus live Collaborate customers? They're C8-family payers in CDXP and have TRX databases, but they aren't in the Customer Overview.
  - Is Centene a live Collaborate customer, and is the Centene CORE feed on in Prod?
  - Are any other CDXP payers also Collaborate customers?
  - Which payers are Hybrid in PROD? The CDXP KB says Optum and Centene; the local bootstrap script also flags BCBSMI.
