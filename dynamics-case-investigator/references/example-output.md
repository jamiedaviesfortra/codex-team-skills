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
- Contradictory evidence: [describe material conflict if sources disagree], with [source] currently appearing stronger because [reason].

## Similar Historical Cases

- CAS-##########, "title": Strong Match. Similarity: [same component/version/error/customer impact]. Outcome: resolution/workaround/closure reason. Time to resolution: X days if available.
- CAS-##########, "title": Partial Match. Similarity: [shared symptom/component]. Validation needed: [version/environment/resolution gap].

## Relevant Jira Records

- PROJECT-12345, "title": Strong Match. Status: [status], priority: [priority], affected/fix version if available. Why it matters: [specific symptom/error/version/workaround/engineering conclusion].
- PROJECT-67890, "title": Partial Match. Status: [status]. Why it matters: [specific relationship]. Validation needed: [version/product confirmation].

## Excluded Results

- CAS-##########: Excluded. Reason: product name matched, but symptom/version/resolution did not align.
- PROJECT-00000: Excluded. Reason: keyword overlap only; no concrete relationship to the current issue.

If none were excluded:

No reviewed sources were excluded.

## Evidence Used

- Source Type: Current Dynamics Case. Source: CAS-##########. Supports: [claim] because [specific reviewed evidence].
- Source Type: Historical Dynamics Case. Source: CAS-##########. Supports: [claim] because [resolved outcome / workaround / matching error].
- Source Type: Jira Record. Source: PROJECT-12345. Supports: [claim] because [confirmed engineering conclusion / affected version / workaround].
- Source Type: Official Product Documentation / Release Notes / Known Issue Record. Source: [link or reference]. Supports: [claim] because [specific guidance or fix statement].
- Source Type: Customer-Provided Evidence. Source: [log, screenshot, reproduction detail, or customer confirmation]. Supports or contradicts: [claim] because [specific evidence].

## Evidence Missing

- [Specific log, screenshot, exact build, configuration value, reproduction detail, customer confirmation, Product/Engineering confirmation, or documentation reference] is needed before [claim or guidance] can be trusted.
- [Version or environment detail] is needed to confirm whether [historical case/Jira/documentation] applies.

## Retrieval Limits

Searches attempted:

- Exact match path: current case number, exact title or distinctive phrase, exact error text, Jira keys, defect IDs, event IDs, or stack fragments.
- Product context path: product, component, version, module, service, integration, or release.
- Symptom path: customer impact, functional failure, observed behavior, error condition, or reproduction terms.
- Resolution path: workaround, resolution, known issue, engineering conclusion, closure note, or defect description terms.
- Search by customer/account or partner.
- Jira search by product/component plus symptom/error.

Possible gaps:

- All material evidence came from [one/multiple] search path(s); retrieval quality was adjusted accordingly.
- Search paths [agreed/conflicted] on [material point].
- Similar records may use different terminology.
- Older cases may have incomplete resolution notes.
- Broad product or symptom matches were excluded unless a concrete similarity was found.
- Validated/indexed knowledge sources may be unavailable in the active environment.

## Retrieval Quality Assessment

Retrieval quality: Medium.

Relevant sources were found and reviewed across [search paths used], but version applicability, minor source conflicts, or Product/Engineering confirmation remain open. Retrieval quality influences confidence but does not automatically determine it. Example: retrieval quality can be High while confidence remains Low if evidence conflicts, or Medium while confidence is High if fewer sources directly support the conclusion.

## Communication Classification

Customer-Safe:

- [Troubleshooting step, log request, confirmed workaround, or externally appropriate explanation].

Internal-Only:

- [Jira discussion, engineering assumption, internal escalation context, or sensitive internal case note].

Approval Required:

- [Defect confirmation, release commitment, ETA statement, roadmap reference, or product guidance requiring Product/Engineering approval].

## Agent Validation Required

- Confirm the cited historical cases and Jira records are genuinely relevant to the current case.
- Confirm version, environment, and component match before relying on any workaround or defect reference.
- Remove internal-only details from the customer-facing response.
- Do not present a defect, fix, or official workaround unless Product/Engineering evidence or documentation supports it.

## Likely Root Cause

Confidence: Medium.

Most likely [cause], based on [evidence]. Assumption: [assumption]. Missing validation: [data needed].

Supported by:

- [Source type 1]: [source].
- [Source type 2]: [source].

Confidence limitation, if applicable: The conclusion is currently supported by a single source type. Additional independent validation was not available during the investigation.

Contradictory evidence: [describe conflict if material]. Strongest evidence appears to be [source] because [reason]. Confidence was [kept/reduced] because [resolution or unresolved conflict].

For Low confidence:

No firm root cause can be stated from the current evidence. Plausible hypotheses are [hypothesis 1], [hypothesis 2], and [hypothesis 3]. Recommended action is diagnostic only until [missing evidence] is confirmed.

## Recommended Next Steps

- Request/verify [logs, versions, configuration, reproduction steps, SQL summaries, screenshots].
- Check [specific service/table/error/queue/release/known issue].
- Escalate to [team] with [evidence package] if [condition].
- Monitor [case/Jira/release/defect] for [reason].

## Suggested Agent Response

Hi [customer/contact],

Thank you for the details provided so far.

Based on the information currently available, we have confirmed that [confirmed customer-safe finding].

We are still reviewing [open investigation item / suspected cause / validation point], so we are not treating this as confirmed yet.

To continue the investigation, could you please provide [focused missing evidence, logs, screenshots, reproduction details, exact build/version, or environment details]?

Once we have that information, we will review it and provide the next recommended step.

Use only the Customer-Safe items above. Do not include Internal-Only or Approval Required information unless approval has been confirmed.

## Risks / Watchouts

- Do not state [unsupported claim] until [team/source] confirms.
- [Missing evidence] may change the root-cause assessment.
- [Internal-only Jira/Dynamics detail] should not be shared externally.
