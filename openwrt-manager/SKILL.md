---
name: openwrt-manager
description: 专门用于通过 SSH 管理 OpenWrt 路由器配置的技能。支持自动备份系统设置 (/etc/config)、用户凭据、已安装插件列表和 OpenClash 数据，并能将备份还原至路由器。
---

# OpenWrt Manager

## Overview
该技能通过 SSH 自动化 OpenWrt 路由器的备份与恢复流程。
默认目标 IP: `192.168.1.35`
默认备份目录: `%USERPROFILE%\openwrt_backup`

## Instructions

### 1. 执行备份 (Backup)
当用户请求备份路由器时：
1.  **准备环境**: 确保 `%USERPROFILE%\openwrt_backup` 目录存在。
2.  **执行命令**: 调用 `scripts/backup.bat`。
    -   **注意**: 这是一个交互式脚本。你需要告知用户：**“正在启动备份脚本，请在弹出的窗口中输入路由器密码。”**
3.  **验证**: 脚本运行结束后，检查该目录下是否生成了新的 `.tar.gz` 文件。

### 2. 执行恢复 (Restore)
当用户请求恢复路由器时：
1.  **寻找备份**: 先列出 `%USERPROFILE%\openwrt_backup` 目录下的文件，让用户确认要恢复哪一个。
2.  **执行命令**: 调用 `scripts/restore.bat`。
    -   **注意**: 这是一个交互式脚本。你需要告知用户：**“正在启动恢复脚本，请将备份文件拖入弹出窗口，并输入路由器密码。完成后路由器会自动重启。”**

### 3. 注意事项
-   该技能目前依赖于 Windows Batch 脚本。
-   如果用户反馈 IP 不对，请引导用户修改 `scripts/` 目录下的 `.bat` 文件或联系开发者优化。
-   确保本地机器已安装 `ssh` 客户端（Windows 10/11 默认已带）。
