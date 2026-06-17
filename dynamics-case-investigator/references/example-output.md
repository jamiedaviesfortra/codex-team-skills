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

## Evidence Used

- Current case CAS-##########: supports [claim] because [specific reviewed evidence].
- Historical case CAS-##########: supports [claim] because [resolved outcome / workaround / matching error].
- PROJECT-12345: supports [claim] because [confirmed engineering conclusion / affected version / workaround].
- Documentation or release note link: supports [claim] because [specific guidance or fix statement].

## Evidence Missing

- [Specific log, screenshot, exact build, configuration value, reproduction detail, customer confirmation, Product/Engineering confirmation, or documentation reference] is needed before [claim or guidance] can be trusted.
- [Version or environment detail] is needed to confirm whether [historical case/Jira/documentation] applies.

## Retrieval Limits

Searches attempted:

- Exact lookup by current case number.
- Search by exact title or distinctive phrase.
- Search by product/component/version and symptom/error.
- Search by customer/account or partner.
- Jira search by product/component plus symptom/error.

Possible gaps:

- Similar records may use different terminology.
- Older cases may have incomplete resolution notes.
- Broad product or symptom matches were excluded unless a concrete similarity was found.
- Validated/indexed knowledge sources may be unavailable in the active environment.

## Agent Validation Required

- Confirm the cited historical cases and Jira records are genuinely relevant to the current case.
- Confirm version, environment, and component match before relying on any workaround or defect reference.
- Remove internal-only details from the customer-facing response.
- Do not present a defect, fix, or official workaround unless Product/Engineering evidence or documentation supports it.

## Likely Root Cause

Confidence: Medium.

Most likely [cause], based on [evidence]. Assumption: [assumption]. Missing validation: [data needed].

For Low confidence:

No firm root cause can be stated from the current evidence. Plausible hypotheses are [hypothesis 1], [hypothesis 2], and [hypothesis 3]. Recommended action is diagnostic only until [missing evidence] is confirmed.

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
