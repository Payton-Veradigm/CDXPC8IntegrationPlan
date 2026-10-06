# Migrate the customers both products serve

[Back to steps](../steps.md)

- **Who:** BCBS MI, CCOK, Christus, and Horizon (the VPI customers).
- **Fold CDXP's copy of each gap into the Collaborate row.** Carry over delivery status, patient matches, and PayerPath counts.
- **Match on the gap ID chain.** Take care with numeric IDs, which may be Collaborate `DetailId`s.
- **Take gap content from Collaborate.** CDXP's blobs older than 90 days may be gone.
- **Estimate basis:** about 32 dev h per customer, for 4 customers.
