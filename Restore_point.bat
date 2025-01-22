@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges. Attempting to run as administrator...
    :: Relaunch the script with elevated privileges
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Create a restore point
echo Creating a restore point...
powershell.exe -Command "Checkpoint-Computer -Description 'RestorePoint_$(Get-Date -Format ''yyyyMMdd_HHmmss'')' -RestorePointType 'MODIFY_SETTINGS'"

if %errorLevel% equ 0 (
    echo Restore point created successfully.
) else (
    echo Failed to create restore point.
)

pause