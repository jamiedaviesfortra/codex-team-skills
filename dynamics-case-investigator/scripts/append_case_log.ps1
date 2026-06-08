param(
    [string] $LogFile = $(if ($env:CODEX_CASE_LOG_FILE) { $env:CODEX_CASE_LOG_FILE } else { Join-Path (Join-Path $HOME "codex-case-investigation-logs") "case-investigations.csv" }),
    [string] $RunDate = (Get-Date).ToString("o"),
    [string] $Agent = "Unknown",
    [Parameter(Mandatory = $true)]
    [string] $CaseNumber,
    [string] $Customer = "",
    [string] $Product = "",
    [string] $SimilarCasesFound = "0",
    [string] $JiraRecordsFound = "0",
    [ValidateSet("High", "Medium", "Low")]
    [string] $Confidence = "Low",
    [string] $RecommendedAction = "",
    [string] $TimeSavedEstimate = "",
    [string] $AgentRating = "",
    [string] $Outcome = "",
    [string] $Notes = ""
)

$columns = @(
    "Run Date",
    "Agent",
    "Case Number",
    "Customer",
    "Product",
    "Similar Cases Found",
    "Jira Records Found",
    "Confidence",
    "Recommended Action",
    "Time Saved Estimate",
    "Agent Rating",
    "Outcome",
    "Notes"
)

$logPath = [System.IO.Path]::GetFullPath($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($LogFile))
$logDir = Split-Path -Parent $logPath

if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

$row = [ordered]@{
    "Run Date" = $RunDate
    "Agent" = $Agent
    "Case Number" = $CaseNumber
    "Customer" = $Customer
    "Product" = $Product
    "Similar Cases Found" = $SimilarCasesFound
    "Jira Records Found" = $JiraRecordsFound
    "Confidence" = $Confidence
    "Recommended Action" = $RecommendedAction
    "Time Saved Estimate" = $TimeSavedEstimate
    "Agent Rating" = $AgentRating
    "Outcome" = $Outcome
    "Notes" = $Notes
}

$object = [pscustomobject]$row
$needsHeader = -not (Test-Path $logPath) -or ((Get-Item $logPath).Length -eq 0)

if ($needsHeader) {
    $object | Select-Object $columns | Export-Csv -Path $logPath -NoTypeInformation -Encoding UTF8
} else {
    $object | Select-Object $columns | Export-Csv -Path $logPath -NoTypeInformation -Append -Encoding UTF8
}

Write-Host "Appended case investigation log row to $logPath"
