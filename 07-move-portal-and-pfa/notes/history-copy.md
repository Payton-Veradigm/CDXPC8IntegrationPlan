# Copy each customer's feedback, documents, and history

[Back to steps](../steps.md)

- Carry out [the feedback and documents decision](../../05-cut-in-and-verify/notes/feedback-and-documents.md).
- **What moves:** feedback and its history, "not seen here", document records, and member and gap history, within [the history scope](../../05-cut-in-and-verify/notes/migration-scope.md). The chart bytes go to [Blob Storage](chart-files-to-blob.md).
- **How:** extend CIEP's history migration routine (#170105) so it can read a TRX database.
- **Reconcile** with row counts and checksums before the customer moves.
