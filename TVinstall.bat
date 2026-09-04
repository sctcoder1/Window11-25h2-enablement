@echo off
setlocal EnableExtensions

set "ASSIGNMENT_ID=%~1"
set "MSI=%~dp0TeamViewer_Host.msi"

if not defined ASSIGNMENT_ID (
    echo ERROR: TeamViewer assignment ID was not supplied.
    exit /b 10
)

if not exist "%MSI%" (
    echo ERROR: TeamViewer MSI not found: "%MSI%"
    exit /b 11
)

echo Installing TeamViewer Host...
msiexec.exe /i "%MSI%" /qn /norestart REBOOT=ReallySuppress
set "MSIRC=%ERRORLEVEL%"

if not "%MSIRC%"=="0" if not "%MSIRC%"=="3010" (
    echo ERROR: TeamViewer MSI installation failed with exit code %MSIRC%.
    exit /b %MSIRC%
)

if "%MSIRC%"=="3010" (
    echo TeamViewer installed successfully. A restart was recommended, but no restart will be performed.
)

echo Waiting for TeamViewer.exe...

set "TVEXE="
for /L %%I in (1,1,60) do (
    if exist "C:\Program Files\TeamViewer\TeamViewer.exe" (
        set "TVEXE=C:\Program Files\TeamViewer\TeamViewer.exe"
        goto :ASSIGN
    )
    if exist "C:\Program Files (x86)\TeamViewer\TeamViewer.exe" (
        set "TVEXE=C:\Program Files (x86)\TeamViewer\TeamViewer.exe"
        goto :ASSIGN
    )
    timeout /t 1 /nobreak >nul
)

echo ERROR: TeamViewer.exe was not found after installation.
exit /b 12

:ASSIGN
echo Assigning TeamViewer device...
"%TVEXE%" assignment --id "%ASSIGNMENT_ID%"
set "ASSIGNRC=%ERRORLEVEL%"

if not "%ASSIGNRC%"=="0" (
    echo ERROR: TeamViewer assignment failed with exit code %ASSIGNRC%.
    exit /b %ASSIGNRC%
)

echo TeamViewer installation and assignment completed successfully.
exit /b 0
