# Example Output Pattern

Use this pattern as a shape guide, not as reusable facts.

## Case Overview

CAS-##########: "case title"

Customer/account, contact if available, product/service, version/environment, status, owner/team, priority/severity, created/modified dates when useful, attachments or linked records when relevant.

Plain-language issue summary and customer impact.

## Key Findings

- Current evidence suggests [clarification / configuration issue / environment issue / known defect / product behavior / unknown].
- Historical cases show [pattern], with [resolution/workaround] when available.
- Jira records show [linked defect/known issue/escalation/release item], or no relevant Jira records were found.

## Similar Historical Cases

- CAS-##########, "title": similarity reason. Outcome: resolution/workaround/closure reason. Time to resolution: X days if available.

## Relevant Jira Records

- PROJECT-12345, "title": status, priority, affected/fix version if available. Why it matters to this case.

## Likely Root Cause

Confidence: Medium.

Most likely [cause], based on [evidence]. Assumption: [assumption]. Missing validation: [data needed].

## Recommended Next Steps

- Request/verify [logs, versions, configuration, reproduction steps, SQL summaries, screenshots].
- Check [specific service/table/error/queue/release/known issue].
- Escalate to [team] with [evidence package] if [condition].
- Monitor [case/Jira/release/defect] for [reason].

## Suggested Agent Response

Hi [customer/contact],

Thank you for the details. Based on the information currently available, [plain-language explanation without overclaiming]. To confirm the next step, could you please provide [focused missing evidence]? Once we have this, we can [next action].

## Risks / Watchouts

- Do not state [unsupported claim] until [team/source] confirms.
- [Missing evidence] may change the root-cause assessment.
- [Internal-only Jira/Dynamics detail] should not be shared externally.
