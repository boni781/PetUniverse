[CmdletBinding()]
param(
    [string]$PackagePath = '',
    [string]$InstallDirectory = (Join-Path $env:LOCALAPPDATA 'Programs\PetUniverse'),
    [switch]$NoLaunch
)

$ErrorActionPreference = 'Stop'

# release.py replaces these constants in the versioned installer asset.
$AppVersion = '__APP_VERSION__'
$ExecutableName = '__EXECUTABLE_NAME__'
$DownloadUrl = '__PACKAGE_URL__'
$ExpectedSha256 = '__PACKAGE_SHA256__'
$RuntimeUrl = 'https://aka.ms/vc14/vc_redist.x64.exe'

function Write-InstallerLog {
    param([string]$Message)
    Write-Host "[PetUniverse Installer] $Message"
}

function Test-VcRuntimeInstalled {
    $keys = @(
        'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x64'
    )

    foreach ($key in $keys) {
        try {
            $runtime = Get-ItemProperty -Path $key -ErrorAction Stop
            if ($runtime.Installed -eq 1) {
                return $true
            }
        }
        catch {
            continue
        }
    }
    return $false
}

function Install-VcRuntimeIfRequired {
    if (Test-VcRuntimeInstalled) {
        Write-InstallerLog 'Visual C++ Runtime sudah tersedia.'
        return
    }

    Write-InstallerLog 'Mengunduh Visual C++ Runtime resmi dari Microsoft.'
    $runtimeInstaller = Join-Path $env:TEMP 'PetUniverse-vc_redist.x64.exe'
    Invoke-WebRequest -Uri $RuntimeUrl -OutFile $runtimeInstaller -UseBasicParsing
    $signature = Get-AuthenticodeSignature -FilePath $runtimeInstaller
    if ($signature.Status -ne 'Valid' -or $signature.SignerCertificate.Subject -notmatch 'Microsoft') {
        throw 'Paket Visual C++ Runtime tidak memiliki tanda tangan Microsoft yang valid.'
    }

    $process = Start-Process -FilePath $runtimeInstaller -ArgumentList '/install', '/quiet', '/norestart' -Wait -PassThru
    if ($process.ExitCode -notin @(0, 3010, 1638)) {
        throw "Instalasi Visual C++ Runtime gagal dengan exit code $($process.ExitCode)."
    }
}

$installFullPath = [System.IO.Path]::GetFullPath($InstallDirectory)
$installParent = Split-Path -Parent $installFullPath
$installLeaf = Split-Path -Leaf $installFullPath
$token = [Guid]::NewGuid().ToString('N')
$stagePath = Join-Path $installParent ".$installLeaf-stage-$token"
$backupPath = Join-Path $installParent ".$installLeaf-backup-$token"
$downloadedPackage = $false
$installWasMoved = $false

try {
    if (-not $PackagePath) {
        $PackagePath = Join-Path $PSScriptRoot (Split-Path -Leaf $DownloadUrl)
    }

    if (-not (Test-Path -LiteralPath $PackagePath -PathType Leaf)) {
        if ([string]::IsNullOrWhiteSpace($DownloadUrl) -or $DownloadUrl.StartsWith('__')) {
            throw 'URL unduhan belum diatur dan file ZIP tidak diberikan.'
        }
        $PackagePath = Join-Path $env:TEMP "PetUniverse-$AppVersion-windows-x64.zip"
        Write-InstallerLog "Mengunduh PetUniverse v$AppVersion."
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $PackagePath -UseBasicParsing
        $downloadedPackage = $true
    }

    Write-InstallerLog 'Memverifikasi SHA-256 paket.'
    $actualHash = (Get-FileHash -LiteralPath $PackagePath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualHash -ne $ExpectedSha256.Trim().ToLowerInvariant()) {
        throw 'SHA-256 paket tidak cocok. Installer membatalkan pemasangan.'
    }

    # Do not replace a running application; let the user close it first.
    $processName = [System.IO.Path]::GetFileNameWithoutExtension($ExecutableName)
    $running = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($null -ne $running) {
        throw 'PetUniverse sedang berjalan. Tutup aplikasi terlebih dahulu, lalu jalankan installer kembali.'
    }

    Install-VcRuntimeIfRequired

    New-Item -ItemType Directory -Path $installParent -Force | Out-Null
    if (Test-Path -LiteralPath $stagePath) {
        Remove-Item -LiteralPath $stagePath -Recurse -Force
    }
    New-Item -ItemType Directory -Path $stagePath -Force | Out-Null

    Write-InstallerLog 'Mengekstrak aplikasi.'
    Expand-Archive -LiteralPath $PackagePath -DestinationPath $stagePath -Force
    if (-not (Test-Path -LiteralPath (Join-Path $stagePath $ExecutableName) -PathType Leaf)) {
        throw "Executable $ExecutableName tidak ditemukan di ZIP."
    }
    if (-not (Test-Path -LiteralPath (Join-Path $stagePath 'updater\apply_update.ps1') -PathType Leaf)) {
        throw 'File updater tidak ditemukan di dalam paket.'
    }

    if (Test-Path -LiteralPath $installFullPath) {
        Write-InstallerLog 'Mencadangkan instalasi sebelumnya.'
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

    $exePath = Join-Path $installFullPath $ExecutableName
    $shell = New-Object -ComObject WScript.Shell

    $startMenu = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs'
    New-Item -ItemType Directory -Path $startMenu -Force | Out-Null
    $startShortcut = $shell.CreateShortcut((Join-Path $startMenu 'PetUniverse.lnk'))
    $startShortcut.TargetPath = $exePath
    $startShortcut.WorkingDirectory = $installFullPath
    $startShortcut.Description = "PetUniverse v$AppVersion"
    $startShortcut.Save()

    $desktop = [Environment]::GetFolderPath('Desktop')
    $desktopShortcut = $shell.CreateShortcut((Join-Path $desktop 'PetUniverse.lnk'))
    $desktopShortcut.TargetPath = $exePath
    $desktopShortcut.WorkingDirectory = $installFullPath
    $desktopShortcut.Description = "PetUniverse v$AppVersion"
    $desktopShortcut.Save()

    Write-InstallerLog "PetUniverse v$AppVersion berhasil dipasang di $installFullPath."
    if (-not $NoLaunch) {
        Start-Process -FilePath $exePath -WorkingDirectory $installFullPath
    }

    if ($downloadedPackage) {
        Remove-Item -LiteralPath $PackagePath -Force -ErrorAction SilentlyContinue
    }
    if ($installWasMoved) {
        Write-InstallerLog "Cadangan instalasi lama disimpan di $backupPath."
    }
    exit 0
}
catch {
    Write-Error "[PetUniverse Installer] Pemasangan gagal: $($_.Exception.Message)"
    if ($installWasMoved -and (Test-Path -LiteralPath $backupPath)) {
        if (Test-Path -LiteralPath $installFullPath) {
            Remove-Item -LiteralPath $installFullPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        Move-Item -LiteralPath $backupPath -Destination $installFullPath -ErrorAction SilentlyContinue
        Write-InstallerLog 'Instalasi sebelumnya dipulihkan.'
    }
    if (Test-Path -LiteralPath $stagePath) {
        Remove-Item -LiteralPath $stagePath -Recurse -Force -ErrorAction SilentlyContinue
    }
    exit 1
}
