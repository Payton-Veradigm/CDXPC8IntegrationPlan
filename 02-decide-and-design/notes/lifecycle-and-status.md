# Decide the gap lifecycle and status rules

[Back to steps](../steps.md)

- **Lean:** two separate dimensions.
  - **Program lifecycle**, owned by the payer and Collaborate: in source, expired, responded, closed.
  - **Delivery**, owned by CDXP: New, Sent, Viewed, Addressed, SentToPayer, FailedAtSentToPayer, Expired.
- **Rules to write down:**
  - **Reopening.** Does a completed gap reopen when it comes back? The sources disagree. The Collaborate KB says completed alerts don't reopen on staging. Jason's proposal says Collaborate reopens returning gaps for feedback. CDXP's payer tables never reopen a closed gap.
  - **What expiry means.**
    - Collaborate: absent from a complete dataset.
    - CDXP: absent from the latest feed, unless more than 20% of open gaps would expire.
    - Centene: expiry is scoped to its tracker.
  - **The realtime path.** How does its reopen rule fit (`DaysToReopenGaps`, default 1000 days)?
  - **Concurrent program years.** BCBSMI needs them in 2027.
