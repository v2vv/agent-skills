---
name: ssh-setup
description: Automates the process of setting up SSH key-based authentication on a remote server. Use this skill when the user wants to copy their local public key to a remote host to enable password-less login.
---

# SSH Setup

## Overview

This skill helps configure SSH key-based authentication. It handles:
1.  Checking for an existing local SSH key pair.
2.  Generating a new key pair if none exists.
3.  Copying the public key to a specified remote host.

## Instructions

1.  **Check for Local Key**:
    - Look for SSH keys in the user's `.ssh` directory (e.g., `~/.ssh/id_ed25519.pub` or `~/.ssh/id_rsa.pub`).
    - **Action**: Check if the file exists using your file tools.
    - If **no key is found**:
        - Ask the user if they want to generate one.
        - If yes, use `run_shell_command` to generate it: `ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\id_ed25519" -N ""` (Note: This creates a key with NO passphrase for convenience. Ask the user if they prefer a passphrase).

2.  **Get Remote Details**:
    - Ask the user for the `username` and `hostname` (or IP) of the remote server.
    - Ask for the `port` (default is 22).

3.  **Deploy Public Key**:
    - To copy the key, you need to append the local public key content to the remote `~/.ssh/authorized_keys` file.
    - **Method A (PowerShell Script)**:
        - Use the bundled script `scripts/deploy_key.ps1`.
        - Command: `powershell -ExecutionPolicy Bypass -File "scripts/deploy_key.ps1" -User <username> -HostName <hostname> -Port <port> -PubFile <path_to_pub_key>`
    - **Method B (Manual Command Construction)**:
        - If the script fails or you prefer to show the user the command:
        - Construct the command: `Get-Content <pub_key_path> | ssh <user>@<host> "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"`
        - **Important**: This step will require the user's password for the remote server. The `ssh` command will prompt for it.
    - **Action**: Run the command. If it hangs waiting for input (password), you may need to instruct the user to run it themselves in their terminal.

4.  **Verify**:
    - Ask the user to verify login by running: `ssh <user>@<host>`
