@echo off
setlocal
set "INSTALLER=%~dp0PetUniverse-Setup-__APP_VERSION__.ps1"

if not exist "%INSTALLER%" (
    echo File installer tidak ditemukan:
    echo %INSTALLER%
    pause
    exit /b 1
)

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%INSTALLER%" %*
set "RESULT=%ERRORLEVEL%"

if not "%RESULT%"=="0" (
    echo.
    echo Installer gagal dengan exit code %RESULT%.
    pause
)

exit /b %RESULT%
