---
name: dynamics-case-investigator
description: retrieve and analyze a specific microsoft dynamics support case, then search historical dynamics cases and connected jira/atlassian records to produce an agent-ready investigation summary. use when the user provides a dynamics case number or cas reference and asks for support case review, similar-case research, jira defect or escalation cross-reference, likely root cause, recommended next steps, or a customer-ready agent response. especially useful for microsoft dynamics customer support workflows that require evidence-grounded summaries across current case details, historical cases, known issues, defects, releases, feature requests, and escalations.
---

# Dynamics Case Investigator

## Purpose

Produce a concise, evidence-grounded investigation summary for a Microsoft Dynamics support case by reviewing the current case, finding historically similar Dynamics cases, cross-referencing Jira/Atlassian records, and drafting practical next actions for the support agent.

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

If a field is unavailable or the connector does not return it, do not invent it. Mark it as not found or unavailable only when it matters to the investigation.

### 2. Build search terms from the current case

Extract search terms from the retrieved case before searching. Use several focused searches rather than one broad query:

- Exact case title or distinctive subject phrases.
- Product, component, version, release, module, feature, table name, service name, or integration name.
- Exact error messages, exception names, SQL errors, log file names, queue names, event IDs, or stack fragments.
- Customer/account name and partner name.
- Suspected root cause words, workaround terms, known issue wording, or defect IDs.
- Linked Jira keys or issue titles.

Prefer exact phrases for error text and case numbers. Broaden only after exact or narrow searches fail.

### 3. Search historical Dynamics cases

Search Dynamics for similar or related cases using multiple dimensions:

- Similar subject/title or issue description.
- Same product, feature, version, table, service, collector, integration, error, symptom, or customer impact.
- Same customer/account, partner, environment, release, defect, known issue, root cause, workaround, or resolution.
- Cases that reference any linked Jira keys or related engineering terms.

Review enough case details to verify relevance before including a case in the final answer. Prioritize cases with confirmed resolutions, workarounds, engineering conclusions, or strong symptom matches.

For each relevant historical case, capture:

- Case number and title.
- Similarity reason.
- Outcome, final resolution, workaround, or closure reason.
- Useful troubleshooting steps or evidence requested.
- Status and approximate time to resolution when available.
- Whether it suggests a recurring pattern.

If no similar Dynamics cases are found, explicitly say so.

### 4. Cross-reference Jira/Atlassian

Use the available Jira/Atlassian connector/tool to investigate:

- Jira issues directly linked from the Dynamics case.
- Jira keys or references mentioned in Dynamics notes, comments, emails, attachments, or historical cases.
- Similar Jira records based on product, feature, symptoms, errors, version, release, known issue, defect, escalation, or feature-request language.
- Related defects, known issues, incidents, escalations, feature requests, documentation tasks, release notes, and engineering investigations.

For each relevant Jira record, capture:

- Jira key, title, issue type, status, priority/severity, owner/team if available.
- Product, component, fix version, affected version, release, labels, linked issues, and customer/account references.
- Why the Jira record matters to the current case.
- Any confirmed workaround, engineering conclusion, release target, fix availability, or requested evidence.

Do not treat a Jira record as relevant only because it shares a product name. Explain the concrete similarity.

If no relevant Jira records are found, explicitly say so.

### 5. Synthesize findings and confidence

Separate evidence from assumptions. Root-cause confidence must be one of:

- High: Direct evidence from current case plus matching resolved cases or confirmed Jira defect/known issue.
- Medium: Strong pattern match, but key validation evidence is missing or Jira/Product confirmation is pending.
- Low: Limited or circumstantial evidence; more diagnostics are needed.

Do not claim a product defect, documentation error, customer configuration problem, or official workaround unless supported by Dynamics/Jira evidence or cited documentation.

### 6. Log the investigation

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

List the most relevant previous Dynamics cases. For each, include case number, title if useful, similarity reason, outcome, resolution/workaround, and time to resolution when available. If none were found, write: "No similar historical Dynamics cases were found from the available searches."

### Relevant Jira Records

List relevant Jira tickets. For each, include Jira key, title, issue type/status, priority if useful, linked product/release/version when available, and why it matters. If none were found, write: "No relevant Jira records were found from the available searches."

### Likely Root Cause

Start with `Confidence: High`, `Confidence: Medium`, or `Confidence: Low`.

Then explain the most likely cause based on available evidence. Clearly label assumptions and missing validation data.

### Recommended Next Steps

Provide practical support-agent actions, such as troubleshooting checks, logs or screenshots to request, database or configuration queries to run, records to monitor, duplicate-case handling, escalation path, Product/Engineering questions, documentation checks, and ownership follow-up.

### Suggested Agent Response

Draft a professional customer-facing response aligned with the current case status. Do not overpromise fixes, confirm defects, or declare official guidance unless the evidence supports it. Ask for only the most useful missing information.

### Risks / Watchouts

Highlight missing information, uncertain ownership, potentially stale guidance, duplicate investigation risk, customer sensitivity, SLA warnings, unsupported assumptions, risks of advising database changes, and any Jira status ambiguity.

## Evidence Rules

- Do not invent information.
- Clearly mark assumptions.
- Prefer primary evidence from the current Dynamics case, resolved similar cases, linked Jira issues, and official documentation.
- Do not include irrelevant cases or Jira records just to fill sections.
- If evidence conflicts, say what conflicts and which source appears more reliable.
- Use citations or source references whenever the active environment supports them.
- Avoid exposing private internal notes verbatim when a paraphrase is sufficient for a support summary.
- Do not share internal-only Jira or Dynamics details in the customer-facing response unless they are appropriate for external communication.

## Search Quality Checklist

Before finalizing, verify that you have attempted the following when connector access allows it:

- Exact lookup for the current Dynamics case number.
- Search by exact title or distinctive phrase.
- Search by product/component/version and symptom/error.
- Search by customer/account or partner.
- Search for linked Jira keys and Jira keys found in notes/comments.
- Search Jira by product/component plus symptom/error.
- Review of the highest-similarity historical cases and Jira records before citing them as relevant.

## Style

Write for a busy support agent. Be direct, practical, and concise. Use bullets where they improve scanability. Avoid long narrative explanations. Focus on what the agent should know and do next.
