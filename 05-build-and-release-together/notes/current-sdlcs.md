# Map both teams' current processes side by side

[Back to steps](../steps.md)

- **Why:** sharing code and schema means two release processes meet. Start from what each team does today.
- **Collaborate:**
  - Repo `veradigm-payer-portal`, in the Azure DevOps project Collabor8.
  - Branches: `main` deploys to Dev, `release/*` to QA. Stage and Prod need manual or product approval.
  - Releases weekly, on Wednesday evenings.
  - Database: deployed by SqlPackage, with a publish profile per customer. Pipelines deploy automatically, and DBOps reviews the Prod preview.
  - Environments: Dev, QA, Stage (a copy of production data), and Prod.
- **CDXP:**
  - Repo `Ciep.AppService`, in the Azure DevOps project CIEP.
  - Branches: `DevBranch`, `StgBranch`, and `master`.
  - Numbered releases, for example 2026.09.01.
  - Database: one DACPAC per release, deployed by release pipelines.
  - Environments: Boron (dev), Cadmium (stage), and PROD. Whether a QA environment still exists is unconfirmed.
- **Also compare:** code review, testing, the definition of done, on-call, and how work is tracked.
