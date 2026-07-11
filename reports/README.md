# Review Reports

- Status: Draft
- Owner: QA Governance Board and DevOps & SRE Board
- Review Board: QA Governance Board, DevOps & SRE Board
- Last Review Date: 2026-07-11
- Next Review Date: Before CI gate automation

Every required board review has a human-readable report and a JSON counterpart
that validates against `review-report.schema.json`. The report binds a decision
to one commit SHA and one current milestone; it is stale if either changes.

CI must reject a required review when its JSON is absent, invalid, stale, has a
`REJECTED` decision, or has unclosed conditions. It must reject a report that
claims evidence not present in the repository or retained CI artifacts.

Use the following names for current review outputs:

| Report | File |
|---|---|
| Architecture | `architecture-review.json` |
| Platform Evolution | `platform-evolution-review.json` |
| Implementation | `implementation-review.json` |
| Security | `security-review.json` |
| Performance | `performance-review.json` |
| Product | `product-review.json` |
| Data Governance | `data-governance-review.json` |
| Release Certification | `release-certification.json` |

These are contracts and templates for future CI enforcement. No JSON report is
created here because no new board decision has been issued.
