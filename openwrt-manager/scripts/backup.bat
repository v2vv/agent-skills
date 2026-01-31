@echo off
setlocal enabledelayedexpansion

:: Switch to script directory
cd /d "%~dp0"

echo =======================================================
echo        OpenWrt Backup Tool (Skill Version)
echo =======================================================
echo Target IP: 192.168.1.35
echo.

:: Set Backup Directory to User Profile (C:\Users\v2vv\openwrt_backup)
set BACKUP_DIR=%USERPROFILE%\openwrt_backup
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Generate filename
set MYDATE=%date:~0,4%%date:~5,2%%date:~8,2%
set FILENAME=%BACKUP_DIR%\Backup_%MYDATE%.tar.gz

echo [1] Saving backup to: %FILENAME%
echo [2] Please enter your router password below...
echo -------------------------------------------------------

:: Execute Backup
ssh root@192.168.1.35 "tar -czf - /etc/config /etc/passwd /etc/shadow /usr/lib/opkg/status /etc/dropbear /etc/uhttpd.* /etc/openclash 2>/dev/null" > "%FILENAME%"

echo.
if exist "%FILENAME%" (
    for %%I in ("%FILENAME%") do set FILESIZE=%%~zI
    if !FILESIZE! GTR 1000 (
        echo [SUCCESS] Backup completed!
        echo File size: !FILESIZE! bytes
        echo Location: %FILENAME%
    ) else (
        echo [FAILED] Backup file is too small or empty.
        echo Please check your password and try again.
        del "%FILENAME%"
    )
) else (
    echo [FAILED] File was not created.
)

echo -------------------------------------------------------
echo Press any key to exit...
pause >nul