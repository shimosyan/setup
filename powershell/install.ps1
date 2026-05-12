Write-Output "#"
Write-Output "# Install Powershell..."
Write-Output "#"

winget install -e --id Microsoft.PowerShell --accept-package-agreements --accept-source-agreements

Write-Output ""
Write-Output "#"
Write-Output "# Install Starship..."
Write-Output "#"

winget install -e --id Starship.Starship --accept-package-agreements --accept-source-agreements

Write-Output ""
Write-Output "#"
Write-Output "# Setting up PowerShell Profile..."
Write-Output "#"

$pwshProfileUrl = "https://raw.githubusercontent.com/shimosyan/setup/main/powershell/profile.ps1"

$pwshProfileDir = Split-Path -Parent $PROFILE
$pwshProfilePath = "$pwshProfileDir\Microsoft.Powershell_profile.ps1"

if (!(Test-Path -Path $pwshProfileDir)) {
    Write-Output "Creating directory: $pwshProfileDir"
    New-Item -ItemType Directory -Force -Path $pwshProfileDir
}

Write-Output "Downloading profile from $pwshProfileUrl ..."
Invoke-WebRequest -Uri $pwshProfileUrl -OutFile $pwshProfilePath

Write-Output "PowerShell Profile installed at $pwshProfilePath"

Write-Output ""
Write-Output "#"
Write-Output "# Setting up Starship Config..."
Write-Output "#"

$starshipConfigUrl = "https://raw.githubusercontent.com/shimosyan/setup/main/starship.toml"

$starshipConfigDir = "$HOME\.config"
$starshipConfigPath = "$starshipConfigDir\starship.toml"

if (!(Test-Path -Path $starshipConfigDir)) {
    Write-Output "Creating directory: $starshipConfigDir"
    New-Item -ItemType Directory -Force -Path $starshipConfigDir
}

Write-Output "Downloading Starship config..."
Invoke-WebRequest -Uri $starshipConfigUrl -OutFile $starshipConfigPath

Write-Output "Starship config installed at $starshipConfigPath"
