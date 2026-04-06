param(
  [ValidateSet("start", "stop", "status")]
  [string]$Action = "start",
  [int]$Port = 3000,
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

$pidFile = Join-Path $repoRoot "tmp\pids\server.pid"

function Get-ListeningProcessIds {
  param([int]$TargetPort)

  $connections = Get-NetTCPConnection -LocalPort $TargetPort -State Listen -ErrorAction SilentlyContinue
  if (-not $connections) {
    return @()
  }

  return $connections | Select-Object -ExpandProperty OwningProcess -Unique
}

function Get-ProcessInfo {
  param([int]$ProcessId)

  $process = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
  if (-not $process) {
    return $null
  }

  $commandLine = ""
  try {
    $cim = Get-CimInstance Win32_Process -Filter "ProcessId = $ProcessId" -ErrorAction Stop
    $commandLine = [string]$cim.CommandLine
  } catch {
    $commandLine = ""
  }

  return [pscustomobject]@{
    Id = $ProcessId
    Name = $process.ProcessName
    CommandLine = $commandLine
  }
}

function Test-IsRailsProcess {
  param($ProcessInfo)

  if (-not $ProcessInfo) {
    return $false
  }

  if ($ProcessInfo.Name -ne "ruby") {
    return $false
  }

  $cmd = $ProcessInfo.CommandLine.ToLowerInvariant()
  return ($cmd -match "rails\s+server") -or ($cmd -match "bin\\rails") -or ($cmd -match "puma")
}

function Stop-ProcessSafely {
  param(
    [int]$ProcessId,
    [string]$Reason
  )

  $info = Get-ProcessInfo -ProcessId $ProcessId
  if (-not $info) {
    return
  }

  if ((Test-IsRailsProcess -ProcessInfo $info) -or $Force) {
    Write-Output "Stopping process $($info.Id) ($($info.Name)) - $Reason"
    Stop-Process -Id $info.Id -Force
    return
  }

  throw "Port/process conflict from process $($info.Id) ($($info.Name)). Use -Force if you want this script to stop it."
}

if ($Action -eq "status") {
  if (Test-Path $pidFile) {
    Write-Output "PID file: $pidFile"
    Write-Output "PID value: $(Get-Content $pidFile -Raw)"
  } else {
    Write-Output "PID file: none"
  }

  $pids = Get-ListeningProcessIds -TargetPort $Port
  if ($pids.Count -eq 0) {
    Write-Output ("Port " + $Port + ": free")
  } else {
    Write-Output ("Port " + $Port + " listeners:")
    foreach ($id in $pids) {
      $info = Get-ProcessInfo -ProcessId $id
      if ($info) {
        Write-Output "- PID $($info.Id) [$($info.Name)] $($info.CommandLine)"
      }
    }
  }

  exit 0
}

if ($Action -eq "stop") {
  foreach ($id in (Get-ListeningProcessIds -TargetPort $Port)) {
    Stop-ProcessSafely -ProcessId $id -Reason "listening on port $Port"
  }

  if (Test-Path $pidFile) {
    Remove-Item $pidFile -Force
    Write-Output "Removed stale PID file."
  }

  Write-Output "Server stop cleanup complete."
  exit 0
}

if (Test-Path $pidFile) {
  $rawPid = (Get-Content $pidFile -Raw).Trim()
  $parsedPid = 0
  [void][int]::TryParse($rawPid, [ref]$parsedPid)

  if ($parsedPid -gt 0) {
    Stop-ProcessSafely -ProcessId $parsedPid -Reason "PID file reference"
  }

  Remove-Item $pidFile -Force
  Write-Output "Removed stale PID file."
}

foreach ($id in (Get-ListeningProcessIds -TargetPort $Port)) {
  Stop-ProcessSafely -ProcessId $id -Reason "listening on port $Port"
}

if ((Get-ListeningProcessIds -TargetPort $Port).Count -gt 0) {
  throw "Port $Port is still occupied after cleanup."
}

Write-Output "Starting Rails server on port $Port..."
& ruby .\bin\rails server -p $Port
