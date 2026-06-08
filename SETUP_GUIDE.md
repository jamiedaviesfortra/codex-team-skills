# Dynamics Case Investigator Setup Guide

Use this guide to install the shared Codex skill and enable team-wide investigation logging on Mac or Windows.

## What This Installs

The installer sets up the `dynamics-case-investigator` skill for Codex and connects it to the shared case investigation report file:

```text
case-investigations.csv
```

After setup, each completed case investigation can append a row to the shared report with case number, customer, product, similar cases, Jira records, confidence, recommended action, time saved estimate, rating, outcome, and notes.

## Requirements

Before starting, confirm you have:

- Access to the GitHub repo: `https://github.com/jamiedaviesfortra/codex-team-skills`
- Access to the SharePoint folder: `Teams-CustomerEngagement / Shared Documents / Codex Case Investigation Logs`
- Git installed and available
- Microsoft OneDrive installed and signed in with your Fortra account
- Codex installed

## Mac Setup

1. Download or clone the GitHub repo:

```bash
git clone https://github.com/jamiedaviesfortra/codex-team-skills.git ~/codex-team-skills
```

If the repo already exists, update it instead:

```bash
cd ~/codex-team-skills
git pull
```

2. Open Finder and go to:

```text
~/codex-team-skills
```

3. Double-click:

```text
Install Dynamics Case Investigator.command
```

4. If macOS blocks the installer, right-click the file, choose **Open**, then confirm.

5. The installer opens the SharePoint log folder in your browser. Click **Sync** in SharePoint and allow Microsoft OneDrive to open.

6. Wait for OneDrive to finish syncing the folder, then return to the installer window and press **Return**.

7. When setup completes, restart Codex.

## Windows Setup

1. Download or clone the GitHub repo:

```powershell
git clone https://github.com/jamiedaviesfortra/codex-team-skills.git "$HOME\codex-team-skills"
```

If the repo already exists, update it instead:

```powershell
cd "$HOME\codex-team-skills"
git pull
```

2. Open File Explorer and go to:

```text
%USERPROFILE%\codex-team-skills
```

3. Double-click:

```text
Install-DynamicsCaseInvestigator.cmd
```

4. If Windows prompts for confirmation, allow the script to run.

5. The installer opens the SharePoint log folder in your browser. Click **Sync** in SharePoint and allow Microsoft OneDrive to open.

6. Wait for OneDrive to finish syncing the folder, then return to the installer window and press **Enter**.

7. When setup completes, restart Codex.

## What The Installer Does

The installer:

- Clones or updates the team skills repo.
- Installs the skill into the local Codex skills folder.
- Opens the SharePoint folder for OneDrive sync.
- Finds or creates the shared `case-investigations.csv` file.
- Sets `CODEX_CASE_LOG_FILE` to the synced CSV path.

On Mac, the skill is linked into:

```text
~/.codex/skills/dynamics-case-investigator
```

On Windows, the skill is linked or copied into:

```text
%USERPROFILE%\.codex\skills\dynamics-case-investigator
```

## Verify Setup

After restarting Codex, start a new Codex thread and ask:

```text
Use $dynamics-case-investigator to review CAS-0010812184
```

To check the shared log path:

Mac:

```bash
echo "$CODEX_CASE_LOG_FILE"
```

Windows PowerShell:

```powershell
$env:CODEX_CASE_LOG_FILE
```

The path should point to the synced OneDrive or SharePoint copy of:

```text
case-investigations.csv
```

## How To Use The Skill

In Codex, ask for a Dynamics case review. Examples:

```text
Use $dynamics-case-investigator to review CAS-0010812184
```

```text
Please review Dynamics case CAS-0010812184, find similar Dynamics cases, cross-reference Jira, and provide recommended next steps.
```

The skill should produce an agent-ready investigation summary and append one reporting row to the shared CSV.

## Reporting Fields

The shared CSV contains:

```text
Run Date
Agent
Case Number
Customer
Product
Similar Cases Found
Jira Records Found
Confidence
Recommended Action
Time Saved Estimate
Agent Rating
Outcome
Notes
```

`Agent Rating` and `Outcome` remain blank unless provided or known.

## Updating Later

To get the latest skill and installer updates:

Mac:

```bash
cd ~/codex-team-skills
git pull
```

Windows PowerShell:

```powershell
cd "$HOME\codex-team-skills"
git pull
```

Restart Codex after pulling updates.

## Troubleshooting

If the skill is not available in Codex:

- Confirm Codex was restarted after setup.
- Confirm the skill exists in `~/.codex/skills` on Mac or `%USERPROFILE%\.codex\skills` on Windows.
- Pull the latest repo and rerun the installer.

If the team report is not updating:

- Confirm OneDrive is running and synced.
- Confirm `CODEX_CASE_LOG_FILE` is set.
- Confirm the path points to `case-investigations.csv` in the SharePoint-synced folder.
- Restart Codex after setting or changing `CODEX_CASE_LOG_FILE`.

If the installer cannot find the SharePoint folder:

- Open the SharePoint folder manually.
- Click **Sync** again.
- Confirm OneDrive is signed in with your Fortra account.
- Wait for the folder to appear locally, then rerun the installer.

## Notes

The installer cannot silently approve Microsoft, OneDrive, or SharePoint prompts. Users still need to sign in and click **Sync** when prompted.

The shared CSV approach is suitable for lightweight team reporting. If many users write at exactly the same time, OneDrive may create sync conflicts; a SharePoint List or Microsoft List is the stronger long-term option for larger reporting workflows.
