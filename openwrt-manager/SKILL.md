# OpenWrt Manager

## Description
A specialized skill for managing OpenWrt router configurations via SSH. It automates the process of backing up and restoring system settings, user credentials, installed plugins lists, and OpenClash data.

## Capabilities
1.  **Backup**: Creates a comprehensive `.tar.gz` archive of `/etc/config`, `/etc/passwd`, `/etc/shadow`, `/usr/lib/opkg/status`, and `/etc/openclash`.
2.  **Restore**: Restores a selected backup archive to the router and automatically reboots it.

## Prerequisites
-   **Router IP**: Defaults to `192.168.1.35`.
-   **SSH Access**: Requires root password (or SSH key) for the router.
-   **Environment**: Windows (uses batch scripts).

## Usage Instructions

### To Backup
Run the backup script. It will ask for the router password once.
The backup file will be saved to `%USERPROFILE%\openwrt_backup`.

```powershell
Start-Process "scripts/backup.bat"
```

### To Restore
Run the restore script. You will need to drag and drop the backup file into the window and enter the password.

```powershell
Start-Process "scripts/restore.bat"
```

## Files
-   `scripts/backup.bat`: The backup logic.
-   `scripts/restore.bat`: The restore logic.
