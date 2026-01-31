@echo off
setlocal

:: Switch to script directory
cd /d "%~dp0"

echo =======================================================
echo        OpenWrt Restore Tool (Skill Version)
echo =======================================================
echo [WARNING] This will OVERWRITE your current settings!
echo [INFO] Router will REBOOT after restoration.
echo.

:ASK_FILE
set /p BACKUP_FILE="Please DRAG the backup file(.tar.gz) here and press Enter: "

:: Remove quotes from path
set BACKUP_FILE=%BACKUP_FILE:"=%

if not exist "%BACKUP_FILE%" (
    echo [ERROR] File not found. Please try again.
    echo.
    goto ASK_FILE
)

echo.
echo Restoring: "%BACKUP_FILE%"
echo -------------------------------------------------------
echo Please enter router password to START...

:: Local read -> SSH pipe -> Remote extract -> Reboot
type "%BACKUP_FILE%" | ssh root@192.168.1.35 "tar -xzf - -C / && sync && echo [OK] Rebooting... && reboot"

if %errorlevel% equ 0 (
    echo.
    echo =======================================================
    echo        RESTORATION COMMAND SENT
    echo =======================================================
    echo Router is rebooting. Please wait 2-3 minutes.
) else (
    echo.
    echo [ERROR] Restoration failed. Check password or connection.
)

echo.
pause