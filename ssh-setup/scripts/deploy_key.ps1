param(
    [string]$User,
    [string]$HostName,
    [string]$PubFile,
    [string]$Port = "22"
)

# Set default public key path if not provided
if ([string]::IsNullOrEmpty($PubFile)) {
    $PubFile = "$env:USERPROFILE\.ssh\id_ed25519.pub"
    if (-not (Test-Path $PubFile)) {
        $PubFile = "$env:USERPROFILE\.ssh\id_rsa.pub"
    }
}

if (-not (Test-Path $PubFile)) {
    Write-Error "Public key file not found at $PubFile. Please generate one first."
    exit 1
}

$KeyContent = Get-Content $PubFile -Raw
# Remove newlines/whitespace
$KeyContent = $KeyContent.Trim()

Write-Host "Deploying key from $PubFile to ${User}@${HostName} on port $Port..."

# Remote command to create .ssh directory and append key
$RemoteCommand = "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$KeyContent' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

# Execute SSH command
# Note: This will prompt for password interactively if not already authenticated.
ssh -p $Port "${User}@${HostName}" $RemoteCommand

if ($LASTEXITCODE -eq 0) {
    Write-Host "Success! The key has been copied."
    Write-Host "Try logging in now: ssh -p $Port ${User}@${HostName}"
} else {
    Write-Error "Failed to deploy key. Ensure you typed the password correctly and the remote host is reachable."
}
