# codex-team-skills

Codex Team Skills

For full Mac and Windows setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md).

## One-click setup

Requirements:

- Git installed and available.
- OneDrive installed and signed in with a Fortra account.
- Access to this GitHub repo and the SharePoint log folder.

### Mac

Download or clone this repo, then double-click:

```text
Install Dynamics Case Investigator.command
```

The installer will:

- Clone or update `~/codex-team-skills`.
- Link `dynamics-case-investigator` into `~/.codex/skills`.
- Open the SharePoint log folder so the user can click **Sync** in OneDrive.
- Set `CODEX_CASE_LOG_FILE` to the synced team CSV path.

After setup, restart Codex and use:

```text
Use $dynamics-case-investigator to review CAS-0010812184
```

### Windows

Download or clone this repo, then double-click:

```text
Install-DynamicsCaseInvestigator.cmd
```

The installer will:

- Clone or update `%USERPROFILE%\codex-team-skills`.
- Link or copy `dynamics-case-investigator` into `%USERPROFILE%\.codex\skills`.
- Open the SharePoint log folder so the user can click **Sync** in OneDrive.
- Set the user environment variable `CODEX_CASE_LOG_FILE` to the synced team CSV path.

After setup, restart Codex and use:

```text
Use $dynamics-case-investigator to review CAS-0010812184
```
