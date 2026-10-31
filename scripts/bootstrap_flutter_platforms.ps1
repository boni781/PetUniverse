[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Invoke-Flutter {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & flutter @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Flutter command failed: flutter $($Arguments -join ' ')"
    }
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$appDir = Join-Path $repoRoot "app"
$androidDir = Join-Path $appDir "android"
$iosDir = Join-Path $appDir "ios"

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter SDK was not found in PATH. Install Flutter and reopen PowerShell."
}

if (-not (Test-Path (Join-Path $appDir "pubspec.yaml"))) {
    throw "app/pubspec.yaml was not found. Run this script from a valid PetUniverse checkout."
}

$hasAndroid = Test-Path $androidDir
$hasIos = Test-Path $iosDir

if ($hasAndroid -xor $hasIos) {
    throw "Only one native platform folder exists. Resolve the partial scaffold manually before continuing."
}

$tempRoot = $null

try {
    if (-not ($hasAndroid -and $hasIos)) {
        $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("petuniverse_flutter_" + [guid]::NewGuid().ToString("N"))
        $generatedProject = Join-Path $tempRoot "pet_universe"

        New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

        Write-Host "Generating Android and iOS platform scaffolding..." -ForegroundColor Cyan
        Invoke-Flutter -Arguments @(
            "create",
            "--platforms=android,ios",
            "--org=com.boni781",
            "--project-name=pet_universe",
            "--no-pub",
            $generatedProject
        )

        Copy-Item -Path (Join-Path $generatedProject "android") -Destination $appDir -Recurse
        Copy-Item -Path (Join-Path $generatedProject "ios") -Destination $appDir -Recurse
        Copy-Item -Path (Join-Path $generatedProject ".metadata") -Destination $appDir
        Copy-Item -Path (Join-Path $generatedProject ".gitignore") -Destination (Join-Path $appDir ".gitignore")

        Write-Host "Native Android and iOS folders created." -ForegroundColor Green
    }
    else {
        Write-Host "Android and iOS folders already exist. Skipping generation and continuing verification." -ForegroundColor Yellow
    }

    Push-Location $appDir
    try {
        Write-Host "Resolving Flutter dependencies..." -ForegroundColor Cyan
        Invoke-Flutter -Arguments @("pub", "get")

        Write-Host "Running static analysis..." -ForegroundColor Cyan
        Invoke-Flutter -Arguments @("analyze", "--fatal-infos")

        Write-Host "Running widget tests..." -ForegroundColor Cyan
        Invoke-Flutter -Arguments @("test")
    }
    finally {
        Pop-Location
    }

    Write-Host ""
    Write-Host "Flutter project scaffolding and verification completed." -ForegroundColor Green
    Write-Host "Android and iOS folders are ready."
    Write-Host "Note: iOS builds require macOS and Xcode."
}
finally {
    if ($tempRoot -and (Test-Path $tempRoot)) {
        Remove-Item -Path $tempRoot -Recurse -Force
    }
}
