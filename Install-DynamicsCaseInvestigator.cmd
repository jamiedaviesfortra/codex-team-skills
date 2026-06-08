@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_PATH=%SCRIPT_DIR%Install-DynamicsCaseInvestigator.ps1"

if not exist "%SCRIPT_PATH%" (
  echo Could not find "%SCRIPT_PATH%".
  echo Make sure this file is in the same folder as Install-DynamicsCaseInvestigator.ps1.
  pause
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"
set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
  echo.
  echo Installer exited with code %EXIT_CODE%.
  pause
)

exit /b %EXIT_CODE%
