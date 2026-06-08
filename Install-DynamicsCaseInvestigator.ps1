$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/jamiedaviesfortra/codex-team-skills.git"
$InstallDir = Join-Path $HOME "codex-team-skills"
$SkillsDir = Join-Path (Join-Path $HOME ".codex") "skills"
$SkillName = "dynamics-case-investigator"
$SkillSource = Join-Path $InstallDir $SkillName
$SkillLink = Join-Path $SkillsDir $SkillName

$SharePointUrl = "https://helpsystemsllc.sharepoint.com/sites/Teams-CustomerEngagement/Shared%20Documents/Codex%20Case%20Investigation%20Logs"
$TeamFolderName = "DEPT - Customer Engagement - Codex Case Investigation Logs"
$TeamLogFileName = "case-investigations.csv"
$CsvHeader = "Run Date,Agent,Case Number,Customer,Product,Similar Cases Found,Jira Records Found,Confidence,Recommended Action,Time Saved Estimate,Agent Rating,Outcome,Notes"

function Write-Header {
    Write-Host ""
    Write-Host "=============================================="
    Write-Host "Dynamics Case Investigator setup"
    Write-Host "=============================================="
}

function Write-Info {
    param([string] $Message)
    Write-Host "[INFO] $Message"
}

function Write-Warn {
    param([string] $Message)
    Write-Host "[WARN] $Message"
}

function Stop-Setup {
    param([string] $Message)
    Write-Host "[ERROR] $Message"
    Write-Host ""
    Write-Host "Setup did not complete. You can rerun this installer after fixing the issue."
    Read-Host "Press Enter to close this window"
    exit 1
}

function Find-TeamLogFile {
    $roots = @(
        (Join-Path $HOME "Fortra"),
        (Join-Path $HOME "OneDrive - Fortra"),
        (Join-Path $HOME "OneDrive-Fortra"),
        $env:OneDriveCommercial,
        $env:OneDrive,
        $HOME
    ) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique

    foreach ($root in $roots) {
        $match = Get-ChildItem -Path $root -Filter $TeamLogFileName -Recurse -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -like "*$TeamFolderName*" } |
            Select-Object -First 1

        if ($match) {
            return $match.FullName
        }
    }

    return $null
}

function Find-TeamFolder {
    $roots = @(
        (Join-Path $HOME "Fortra"),
        (Join-Path $HOME "OneDrive - Fortra"),
        (Join-Path $HOME "OneDrive-Fortra"),
        $env:OneDriveCommercial,
        $env:OneDrive,
        $HOME
    ) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique

    foreach ($root in $roots) {
        $match = Get-ChildItem -Path $root -Directory -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -eq $TeamFolderName } |
            Select-Object -First 1

        if ($match) {
            return $match.FullName
        }
    }

    return $null
}

function Install-OrUpdateRepo {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Stop-Setup "Git is not installed or not available in PATH."
    }

    $gitDir = Join-Path $InstallDir ".git"
    if (Test-Path $gitDir) {
        Write-Info "Updating existing repo at $InstallDir"
        git -C $InstallDir pull --ff-only
        if ($LASTEXITCODE -ne 0) {
            Stop-Setup "Could not update $InstallDir"
        }
    } elseif (Test-Path $InstallDir) {
        Stop-Setup "$InstallDir already exists but is not a Git repo. Rename it or remove it, then rerun this installer."
    } else {
        Write-Info "Cloning team skills repo to $InstallDir"
        git clone $RepoUrl $InstallDir
        if ($LASTEXITCODE -ne 0) {
            Stop-Setup "Could not clone $RepoUrl"
        }
    }
}

function Install-SkillLink {
    New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null

    if (-not (Test-Path $SkillSource)) {
        Stop-Setup "Skill folder was not found at $SkillSource"
    }

    if (Test-Path $SkillLink) {
        $item = Get-Item $SkillLink -Force
        if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            Write-Info "Replacing existing skill link"
            Remove-Item $SkillLink -Force
        } else {
            $backup = "$SkillLink.backup.$(Get-Date -Format yyyyMMddHHmmss)"
            Write-Warn "Existing local skill found. Moving it to $backup"
            Move-Item $SkillLink $backup
        }
    }

    try {
        New-Item -ItemType Junction -Path $SkillLink -Target $SkillSource -ErrorAction Stop | Out-Null
        Write-Info "Skill installed as a junction at $SkillLink"
    } catch {
        Write-Warn "Could not create a junction. Copying the skill folder instead."
        Copy-Item -Path $SkillSource -Destination $SkillLink -Recurse -Force
        Write-Info "Skill copied to $SkillLink"
    }
}

function Prepare-TeamLogFile {
    $logPath = Find-TeamLogFile
    if ($logPath) {
        return $logPath
    }

    Write-Info "Opening SharePoint folder. Click Sync and allow Microsoft OneDrive to open."
    try {
        Start-Process $SharePointUrl
    } catch {
        Write-Warn "Could not open SharePoint automatically. Open it manually: $SharePointUrl"
    }

    Read-Host "After OneDrive finishes syncing the folder, press Enter here to continue"

    $logPath = Find-TeamLogFile
    if ($logPath) {
        return $logPath
    }

    $teamFolder = Find-TeamFolder
    if ($teamFolder) {
        $logPath = Join-Path $teamFolder $TeamLogFileName
        Write-Info "Creating $TeamLogFileName in synced team folder."
        Set-Content -Path $logPath -Value $CsvHeader -Encoding UTF8
        return $logPath
    }

    Stop-Setup "Could not find the synced SharePoint folder. Confirm OneDrive is signed in and the folder has synced, then rerun this installer."
}

function Set-TeamLogEnvironmentVariable {
    param([string] $LogPath)

    [Environment]::SetEnvironmentVariable("CODEX_CASE_LOG_FILE", $LogPath, "User")
    $env:CODEX_CASE_LOG_FILE = $LogPath
    Write-Info "Set CODEX_CASE_LOG_FILE for the current Windows user."
}

function Validate-LoggingScript {
    $pythonScript = Join-Path (Join-Path $SkillSource "scripts") "append_case_log.py"
    $powershellScript = Join-Path (Join-Path $SkillSource "scripts") "append_case_log.ps1"

    if (-not (Test-Path $pythonScript)) {
        Stop-Setup "Python logging script not found at $pythonScript"
    }

    if (-not (Test-Path $powershellScript)) {
        Stop-Setup "PowerShell logging script not found at $powershellScript"
    }
}

function Main {
    Write-Header

    Install-OrUpdateRepo
    Install-SkillLink

    $logPath = Prepare-TeamLogFile
    Set-TeamLogEnvironmentVariable -LogPath $logPath
    Validate-LoggingScript

    Write-Host ""
    Write-Host "Setup complete."
    Write-Host ""
    Write-Host "Skill:"
    Write-Host $SkillLink
    Write-Host ""
    Write-Host "Team log file:"
    Write-Host $logPath
    Write-Host ""
    Write-Host "Next step: restart Codex, then use:"
    Write-Host 'Use $dynamics-case-investigator to review CAS-0010812184'
    Write-Host ""
    Read-Host "Press Enter to close this window"
}

Main
