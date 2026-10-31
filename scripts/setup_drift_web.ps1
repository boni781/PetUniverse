param(
    [string]$DriftVersion = "2.35.3"
)

$ErrorActionPreference = "Stop"

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$webRoot = Join-Path $repositoryRoot "app\web"

if (-not (Test-Path (Join-Path $webRoot "index.html"))) {
    throw "Folder app\web belum memiliki index.html. Jalankan 'flutter create . --platforms web' dari folder app terlebih dahulu."
}

New-Item -ItemType Directory -Force -Path $webRoot | Out-Null

$releaseBase = "https://github.com/simolus3/drift/releases/download/drift-$DriftVersion"
$assets = @(
    @{
        Name = "sqlite3.wasm"
        Url = "$releaseBase/sqlite3.wasm"
        Sha256 = "efd308be92a34f3aa15f289a37f213b0230fd80888a1364326ee29579d892d37"
    },
    @{
        Name = "drift_worker.js"
        Url = "$releaseBase/drift_worker.js"
        Sha256 = "a54b81412d4c4ab56653bb9e4c02912b0820bb37e2bba00722ddef4d78083d4a"
    }
)

foreach ($asset in $assets) {
    $destination = Join-Path $webRoot $asset.Name
    $temporary = "$destination.download"

    Write-Host "Mengunduh $($asset.Name) dari Drift $DriftVersion ..."
    Invoke-WebRequest -Uri $asset.Url -OutFile $temporary

    $actualHash = (Get-FileHash -Path $temporary -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualHash -ne $asset.Sha256) {
        Remove-Item $temporary -Force -ErrorAction SilentlyContinue
        throw "Checksum $($asset.Name) tidak cocok. File tidak dipasang."
    }

    Move-Item -Path $temporary -Destination $destination -Force
    Write-Host "OK: $($asset.Name) ($actualHash)"
}

Write-Host ""
Write-Host "Aset Web Drift siap di: $webRoot"
Write-Host "Jalankan dari folder app: flutter run -d chrome"
