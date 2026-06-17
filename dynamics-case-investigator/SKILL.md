---
name: dynamics-case-investigator
description: retrieve and analyze a specific microsoft dynamics support case, then search historical dynamics cases and connected jira/atlassian records, validate source relevance, and produce an evidence-grounded investigation summary with confidence scoring, source traceability, and customer-safe recommendations. use when the user provides a dynamics case number or cas reference and asks for support case review, similar-case research, jira defect or escalation cross-reference, likely root cause, recommended next steps, or a customer-ready agent response. especially useful for microsoft dynamics customer support workflows that require evidence-grounded summaries across current case details, historical cases, known issues, defects, releases, feature requests, and escalations.
---

# Dynamics Case Investigator

## Purpose

Produce a concise, evidence-grounded investigation summary for a Microsoft Dynamics support case by reviewing the current case, finding historically similar Dynamics cases, cross-referencing Jira/Atlassian records, validating source relevance, and drafting practical next actions for the support agent.

Prioritize evidence quality over search quantity. Search results suggest possible relevance; reviewed source evidence establishes relevance.

The investigator's responsibility is not to find supporting evidence for a hypothesis. The investigator's responsibility is to determine what evidence supports, what evidence contradicts, what evidence is missing, and what conclusions can reasonably be reached. Evidence should drive conclusions; conclusions should never drive evidence selection.

## Required Inputs

Ask for missing required information only if it is not already present:

- Dynamics case number or CAS reference.
- Any required scoping constraint the user gives, such as product, account, date range, or Jira project.

Do not require the user to provide customer, product, title, or Jira keys if these can be retrieved from Dynamics or Jira.

## Investigation Workflow

### 1. Retrieve the current Dynamics case

Use the available Microsoft Dynamics connector/tool to retrieve the full case record for the provided case number. Capture all available evidence:

- Case number, title, account/customer, customer contact.
- Product, service, version, brand, platform, operating system, environment, release, or component.
- Description, symptoms, error messages, reproduction details, logs, screenshots, attachments, and linked records.
- Timeline of activity, customer communications, internal notes, handoffs, ownership, queue/team, priority, severity, SLA warnings, and current status.
- Any linked Jira issue keys, defect IDs, known issue IDs, escalation records, feature requests, release references, documentation links, or engineering notes.

If a field is unavailable or the connector does not return it, do not invent it. Mark it as not found or unavailable only when it matters to the investigation. Review internal notes and customer communications for evidence, but paraphrase sensitive content unless exact wording is necessary.

### 2. Build search terms from the current case

Extract search terms from the retrieved case before searching. Use several focused searches rather than one broad query:

- Exact case title or distinctive subject phrases.
- Product, component, version, release, module, feature, table name, service name, or integration name.
- Exact error messages, exception names, SQL errors, log file names, queue names, event IDs, or stack fragments.
- Customer/account name and partner name.
- Suspected root cause words, workaround terms, known issue wording, or defect IDs.
- Linked Jira keys or issue titles.

Prefer exact phrases for error text and case numbers. Broaden only after exact or narrow searches fail.

### 3. Search coverage strategy

Before determining source relevance, use multiple independent retrieval paths when connector access allows:

- Exact match search: exact case title, error message, exception text, stack trace fragments, Jira keys, defect IDs, event IDs, or distinctive case phrases. Attempt these first whenever possible.
- Product context search: product, version, component, module, service, integration, or release. Focus on product-specific patterns and known behaviors.
- Symptom search: customer impact, functional failures, observed behavior, error conditions, or reproduction steps. Focus on what is happening rather than only where it happens.
- Resolution search: workaround terms, resolution terms, known issue language, engineering conclusions, closure notes, or defect descriptions. Focus on how similar issues were resolved.

After searching, compare findings across paths. Identify when multiple paths support the same conclusion, when paths conflict, and when one path finds evidence that another path misses. If all material evidence comes from only one search path, reduce Retrieval Quality Assessment by one level unless there is a clear justification.

### 4. Search historical Dynamics cases

Search Dynamics for similar or related cases using multiple dimensions:

- Similar subject/title or issue description.
- Same product, feature, version, table, service, collector, integration, error, symptom, or customer impact.
- Same customer/account, partner, environment, release, defect, known issue, root cause, workaround, or resolution.
- Cases that reference any linked Jira keys or related engineering terms.

Review enough case details to verify relevance before including a case in the final answer. Search-result ranking must never be treated as proof of relevance. Prioritize cases with confirmed resolutions, workarounds, engineering conclusions, or strong symptom matches.

For each reviewed historical case, capture:

- Case number and title.
- Relevance classification: Strong Match, Partial Match, Weak Match, or Excluded.
- Similarity reason.
- Outcome, final resolution, workaround, or closure reason.
- Useful troubleshooting steps or evidence requested.
- Status and approximate time to resolution when available.
- Whether it suggests a recurring pattern.

If no similar Dynamics cases are found, explicitly say so.

### 5. Validate historical case relevance

Classify each reviewed historical case before using it:

- Strong Match: Same product/component, same version or confirmed cross-version relevance, same symptom/customer impact, and a confirmed resolution, workaround, or engineering conclusion. May be used as primary evidence.
- Partial Match: Concrete similarity exists, but version, environment, component, or resolution still needs validation. May support findings but cannot independently justify High confidence.
- Weak Match: Limited overlap such as similar wording, broad symptom language, or shared product with different symptom/version. May be mentioned as a weak signal but must not materially drive the root cause.
- Excluded: Similarity is keyword-only or product-only, version relevance is unclear, resolution is missing, the case was abandoned, or the relationship cannot be justified. Must not be used as evidence.

List only material excluded sources in the final output; do not clutter the output with every irrelevant search result.

### 6. Cross-reference Jira/Atlassian

Use the available Jira/Atlassian connector/tool to investigate:

- Jira issues directly linked from the Dynamics case.
- Jira keys or references mentioned in Dynamics notes, comments, emails, attachments, or historical cases.
- Similar Jira records based on product, feature, symptoms, errors, version, release, known issue, defect, escalation, or feature-request language.
- Related defects, known issues, incidents, escalations, feature requests, documentation tasks, release notes, and engineering investigations.

For each relevant Jira record, capture:

- Jira key, title, issue type, status, priority/severity, owner/team if available.
- Relevance classification: Strong Match, Partial Match, Weak Match, or Excluded.
- Product, component, fix version, affected version, release, labels, linked issues, and customer/account references.
- Why the Jira record matters to the current case.
- Any confirmed workaround, engineering conclusion, release target, fix availability, or requested evidence.

Do not treat a Jira record as relevant only because it shares a product name. Explain the concrete similarity.

If no relevant Jira records are found, explicitly say so.

### 7. Validate Jira/Atlassian relevance

Classify each reviewed Jira/Atlassian record before using it:

- Strong Match: Directly supports the current issue through matching symptom/error/component/version or a linked Dynamics case, confirmed defect, known issue, workaround, or engineering conclusion.
- Partial Match: Supports the investigation but needs validation, such as version applicability or Product/Engineering confirmation.
- Weak Match: Related but insufficiently similar. It must not materially drive the root cause.
- Excluded: Not sufficiently relevant, keyword-only, product-only, label-only, or lacking an explainable relationship to the current case. Must not be used as evidence.

Shared product names, components, labels, or keyword overlap alone do not establish relevance.

### 8. Synthesize findings, confidence, and communication safety

Separate evidence from assumptions. Track the specific sources that support each key finding, the validation data that is still missing, and any search or connector limits that could affect the answer.

If reviewed sources support materially different conclusions, do not suppress the conflict. Identify the contradiction in Key Findings, Evidence Used, and Likely Root Cause when it affects the investigation outcome. Explain which evidence appears strongest and why. Reduce confidence by one level unless the conflict can be fully resolved.

Root-cause confidence must be one of:

- High: Direct evidence from current case plus matching resolved cases or confirmed Jira defect/known issue.
- Medium: Strong pattern match, but key validation evidence is missing or Jira/Product confirmation is pending.
- Low: Limited or circumstantial evidence; more diagnostics are needed.

Apply confidence gating:

- For Low confidence, do not state a firm root cause. Provide hypotheses and diagnostic next steps only.
- For Medium confidence, state the most likely cause only with clear missing validation.
- For High confidence, require direct current-case evidence plus a matching resolved historical case, confirmed Jira defect/known issue, or official documentation.
- If relevance depends mainly on shared product name, broad symptom wording, or an unverified version match, cap confidence at Low.

Do not claim a product defect, documentation error, customer configuration problem, or official workaround unless supported by Dynamics/Jira evidence or cited documentation.

Rate retrieval quality:

- High: Multiple search paths were used, relevant sources were validated, sources strongly agree, and evidence gaps are minimal.
- Medium: Relevant sources were found, but some search gaps remain, minor source conflicts exist, or version applicability still requires validation.
- Low: Evidence is limited, search gaps are significant, connector limitations affect coverage, findings conflict, or source quality is weak.

Retrieval quality should influence confidence but must not automatically determine confidence.

Classify information before drafting the customer response:

- Customer-Safe: Troubleshooting steps, log requests, confirmed product behavior, confirmed workarounds, or externally appropriate explanations.
- Internal-Only: Jira discussion, engineering assumptions, escalation commentary, internal investigation details, or sensitive internal notes.
- Approval Required: Defect confirmation, release commitments, ETA statements, roadmap references, or guidance needing Product/Engineering approval.

Only Customer-Safe information may appear in the Suggested Agent Response.

### 9. Log the investigation

After producing the investigation summary, append one row to:
`~/codex-case-investigation-logs/case-investigations.csv`

Use `scripts/append_case_log.py` when filesystem access is available. On Windows, use `scripts/append_case_log.ps1` if Python is unavailable.
If `CODEX_CASE_LOG_FILE` is set, the script writes to that shared/team CSV path; otherwise it writes to the local default above.

Use the current date/time for `Run Date`. Use the current Codex/user name if known for `Agent`; otherwise use `Unknown`.

Populate:

- `Case Number` from the reviewed Dynamics case.
- `Customer` from the case account/customer.
- `Product` from the case product/service.
- `Similar Cases Found` as the count of relevant historical Dynamics cases included.
- `Jira Records Found` as the count of relevant Jira records included.
- `Confidence` from the Likely Root Cause section.
- `Recommended Action` as a short summary of the primary next step.
- `Time Saved Estimate` as a rough estimate, for example `30 minutes`.
- `Agent Rating` blank unless provided by the user.
- `Outcome` blank unless known.
- `Notes` with short context or blockers.

Do not log unsupported assumptions as facts. Log only concise operational metadata, not verbatim internal notes or sensitive customer communications.

Command template:

```bash
python3 scripts/append_case_log.py \
  --case-number "CAS-0010812184" \
  --agent "Unknown" \
  --customer "Customer name" \
  --product "Product name" \
  --similar-cases-found 0 \
  --jira-records-found 0 \
  --confidence "Medium" \
  --recommended-action "Primary recommended action" \
  --time-saved-estimate "30 minutes" \
  --notes "Concise non-sensitive note"
```

If the log write fails, still provide the investigation summary and state that the logging step could not be completed.

Windows PowerShell template:

```powershell
.\scripts\append_case_log.ps1 `
  -CaseNumber "CAS-0010812184" `
  -Agent "Unknown" `
  -Customer "Customer name" `
  -Product "Product name" `
  -SimilarCasesFound 0 `
  -JiraRecordsFound 0 `
  -Confidence "Medium" `
  -RecommendedAction "Primary recommended action" `
  -TimeSavedEstimate "30 minutes" `
  -Notes "Concise non-sensitive note"
```

## Output Format

Use the following sections in this exact order unless the user asks for a different format. Keep the final output concise but detailed enough for an agent to act immediately.

### Case Overview

Summarize the current Dynamics case in plain language. Include case number, title, customer/account, product/service affected, version/environment when available, current status, owner/team, priority/severity, created/modified dates when useful, and customer impact or urgency.

### Key Findings

Explain what appears to be happening. Include relevant patterns from historical cases and Jira findings. State clearly when evidence points to clarification, configuration, environment, known defect, product behavior, documentation gap, or unknown cause.

### Similar Historical Cases

List the most relevant previous Dynamics cases. For each, include case number, title if useful, relevance classification, similarity reason, outcome, resolution/workaround, and time to resolution when available. If none were found, write: "No similar historical Dynamics cases were found from the available searches."

### Relevant Jira Records

List relevant Jira tickets. For each, include Jira key, title, relevance classification, issue type/status, priority if useful, linked product/release/version when available, and why it matters. If none were found, write: "No relevant Jira records were found from the available searches."

### Excluded Results

List material reviewed sources that appeared relevant during investigation, could reasonably have influenced findings, and required explicit exclusion due to weak evidence or poor relevance. Include the source identifier, classification, and reason excluded. Do not include every rejected search result; this section is for transparency, not exhaustive reporting. If none were excluded, write: "No reviewed sources were excluded."

### Evidence Used

List the exact Dynamics cases, Jira records, documentation links, release notes, or other sources that support the key findings. For each source, include Source Type, Source, and Supports. Do not cite a source unless it was actually reviewed.

Use these source types when applicable: Current Dynamics Case, Historical Dynamics Case, Jira Record, Engineering Investigation, Official Product Documentation, Knowledge Base Article, Release Notes, Known Issue Record, Product Team Guidance, Customer-Provided Evidence.

### Evidence Missing

List the specific facts, logs, screenshots, version details, customer confirmations, Engineering/Product confirmations, or documentation references needed before the guidance can be trusted.

### Retrieval Limits

Briefly state what searches were attempted and what may have been missed. Include the search coverage paths used, significant differences between paths, and limits such as unavailable connectors, shallow search results, ambiguous terminology, missing historical resolutions, stale records, or lack of indexed/validated knowledge sources.

### Retrieval Quality Assessment

Rate retrieval quality as High, Medium, or Low. Explain the rating in one or two short sentences.

### Communication Classification

Separate important findings or recommendations into Customer-Safe, Internal-Only, and Approval Required. Only Customer-Safe information may appear in the Suggested Agent Response.

### Agent Validation Required

State what the support agent must validate before using the suggested response with the customer. Include checks for source relevance, version match, product/environment applicability, customer-specific assumptions, internal-only details, unsupported defect claims, and whether Product/Engineering confirmation is required.

### Likely Root Cause

Start with `Confidence: High`, `Confidence: Medium`, or `Confidence: Low`.

Then explain the most likely cause based on available evidence. Clearly label assumptions and missing validation data. For Low confidence, do not provide a firm root cause; list plausible hypotheses and the diagnostics needed to confirm or reject them.

### Recommended Next Steps

Provide practical support-agent actions, such as troubleshooting checks, logs or screenshots to request, database or configuration queries to run, records to monitor, duplicate-case handling, escalation path, Product/Engineering questions, documentation checks, and ownership follow-up.

### Suggested Agent Response

Draft a professional customer-facing response aligned with the current case status. Use only Customer-Safe information. Do not overpromise fixes, confirm defects, declare official guidance, expose internal Jira/Dynamics details, or commit to timelines unless approved evidence supports it. Ask for only the most useful missing information.

### Risks / Watchouts

Highlight missing information, uncertain ownership, potentially stale guidance, duplicate investigation risk, customer sensitivity, SLA warnings, unsupported assumptions, risks of advising database changes, and any Jira status ambiguity.

## Evidence Rules

- Do not invent information.
- Do not fabricate evidence.
- Do not overstate confidence.
- Clearly mark assumptions.
- Every key finding should be traceable to a listed source in Evidence Used.
- Prefer, without blindly defaulting to, evidence from the current Dynamics case, customer-provided evidence, official product documentation, confirmed Jira defects, Engineering conclusions, known issue records, release notes, resolved Strong Match historical cases, Partial Match historical cases, and Weak Match historical cases, roughly in that order. If a lower-priority source contradicts a higher-priority source, explain the conflict and prefer the higher-priority source unless evidence clearly justifies otherwise.
- Do not include irrelevant cases or Jira records just to fill sections.
- Do not let weak search-result similarity drive the root cause.
- If relevance depends mainly on shared product name, broad symptom wording, or unverified version match, cap confidence at Low.
- Weak Match sources must not materially drive root cause or customer guidance.
- Contradictory evidence must be documented when it materially affects the investigation outcome.
- Historical cases must not be used as evidence when product names merely match, version relevance is unknown, resolution is missing, similarity is keyword-only, or the resolution was not validated.
- Jira issues must not be used as evidence solely because product names, components, labels, or keywords overlap.
- Suggested customer responses are drafts until the Agent Validation Required checks are complete.
- Use citations or source references whenever the active environment supports them.
- Avoid exposing private internal notes verbatim when a paraphrase is sufficient for a support summary.
- Do not share internal-only Jira or Dynamics details in the customer-facing response unless they are appropriate for external communication.

## Search Quality Checklist

Before finalizing, verify that you have attempted the following when connector access allows it:

- Exact lookup for the current Dynamics case number.
- Search by exact title or distinctive phrase.
- Search by product/component/version.
- Search by symptom/error/customer impact/reproduction terms.
- Search by resolution/workaround/known issue/engineering conclusion terms.
- Search by customer/account or partner.
- Search for linked Jira keys and Jira keys found in notes/comments.
- Search Jira by product/component plus symptom/error.
- Comparison of findings across search coverage paths.
- Review of the highest-similarity historical cases and Jira records before citing them as relevant.
- Relevance classification for each cited historical case and Jira record.
- Retrieval quality rating and communication classification before drafting the customer response.

## Style

Write for a busy support agent. Be direct, practical, and concise. Use bullets where they improve scanability. Avoid long narrative explanations. Focus on what the agent should know and do next.
