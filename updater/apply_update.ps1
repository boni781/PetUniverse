[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InstallDirectory,

    [Parameter(Mandatory = $true)]
    [string]$ArchivePath,

    [Parameter(Mandatory = $true)]
    [string]$ExpectedSha256,

    [Parameter(Mandatory = $true)]
    [int]$ProcessId,

    [Parameter(Mandatory = $true)]
    [string]$ExecutableName,

    [int]$WaitTimeoutSeconds = 120
)

$ErrorActionPreference = 'Stop'

function Write-UpdateLog {
    param([string]$Message)
    Write-Host "[PetUniverse Updater] $Message"
}

function Assert-FileHash {
    param(
        [string]$Path,
        [string]$Expected
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Arsip pembaruan tidak ditemukan: $Path"
    }

    $actual = (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $Expected.Trim().ToLowerInvariant()) {
        throw "SHA-256 arsip tidak cocok. Arsip mungkin rusak atau berubah."
    }
}

$installFullPath = [System.IO.Path]::GetFullPath($InstallDirectory)
$installParent = Split-Path -Parent $installFullPath
$installLeaf = Split-Path -Leaf $installFullPath
$token = [Guid]::NewGuid().ToString('N')
$stagePath = Join-Path $installParent ".$installLeaf-stage-$token"
$backupPath = Join-Path $installParent ".$installLeaf-backup-$token"
$installWasMoved = $false

try {
    Write-UpdateLog "Memvalidasi paket pembaruan."
    Assert-FileHash -Path $ArchivePath -Expected $ExpectedSha256

    Write-UpdateLog "Menunggu aplikasi menutup database dan prosesnya."
    try {
        Wait-Process -Id $ProcessId -Timeout $WaitTimeoutSeconds -ErrorAction Stop
    }
    catch {
        $stillRunning = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
        if ($null -ne $stillRunning) {
            throw "PetUniverse belum menutup dalam $WaitTimeoutSeconds detik. Pembaruan dibatalkan agar data lokal tidak terganggu."
        }
    }

    if (Test-Path -LiteralPath $stagePath) {
        Remove-Item -LiteralPath $stagePath -Recurse -Force
    }
    New-Item -ItemType Directory -Path $stagePath -Force | Out-Null

    Write-UpdateLog "Mengekstrak paket ke folder sementara."
    Expand-Archive -LiteralPath $ArchivePath -DestinationPath $stagePath -Force

    $newExecutable = Join-Path $stagePath $ExecutableName
    if (-not (Test-Path -LiteralPath $newExecutable -PathType Leaf)) {
        throw "Executable $ExecutableName tidak ditemukan di dalam paket."
    }

    $newHelper = Join-Path $stagePath 'updater\apply_update.ps1'
    if (-not (Test-Path -LiteralPath $newHelper -PathType Leaf)) {
        throw "Helper updater tidak ditemukan di dalam paket."
    }

    if (Test-Path -LiteralPath $installFullPath) {
        Write-UpdateLog "Membuat cadangan instalasi sebelumnya."
        Move-Item -LiteralPath $installFullPath -Destination $backupPath
        $installWasMoved = $true
    }

    try {
        Move-Item -LiteralPath $stagePath -Destination $installFullPath
    }
    catch {
        if ($installWasMoved -and -not (Test-Path -LiteralPath $installFullPath)) {
            Move-Item -LiteralPath $backupPath -Destination $installFullPath
            $installWasMoved = $false
        }
        throw
    }

    $installedExecutable = Join-Path $installFullPath $ExecutableName
    if (-not (Test-Path -LiteralPath $installedExecutable -PathType Leaf)) {
        throw "Aplikasi hasil pembaruan tidak ditemukan setelah pemasangan."
    }

    Write-UpdateLog "Pembaruan berhasil. Menjalankan PetUniverse."
    Start-Process -FilePath $installedExecutable -WorkingDirectory $installFullPath

    if (Test-Path -LiteralPath $ArchivePath) {
        Remove-Item -LiteralPath $ArchivePath -Force -ErrorAction SilentlyContinue
    }

    # Backup is intentionally retained for recovery and is not auto-deleted.
    Write-UpdateLog "Cadangan lama: $backupPath"
    exit 0
}
catch {
    Write-Error "[PetUniverse Updater] Pembaruan gagal: $($_.Exception.Message)"

    if ($installWasMoved -and (Test-Path -LiteralPath $backupPath)) {
        if (Test-Path -LiteralPath $installFullPath) {
            Remove-Item -LiteralPath $installFullPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        Move-Item -LiteralPath $backupPath -Destination $installFullPath -ErrorAction SilentlyContinue
        Write-UpdateLog "Instalasi sebelumnya dipulihkan."
    }

    if (Test-Path -LiteralPath $stagePath) {
        Remove-Item -LiteralPath $stagePath -Recurse -Force -ErrorAction SilentlyContinue
    }
    exit 1
}
