Write-Output "#"
Write-Output "# Install tools via winget..."
Write-Output "#"

$packages = @(
    "Microsoft.PowerShell",
    "junegunn.fzf",
    "ajeetdsouza.zoxide",
    "eza-community.eza",
    "jdx.mise",
    "Starship.Starship"
)

foreach ($pkg in $packages) {
    winget install -e --id $pkg --accept-package-agreements --accept-source-agreements --silent
}

Write-Output ""
Write-Output "#"
Write-Output "# Setting up PowerShell 7 Profile..."
Write-Output "#"

$pwshProfileUrl = "https://raw.githubusercontent.com/shimosyan/setup/main/powershell/profile.ps1"

$userDocuments = [Environment]::GetFolderPath('MyDocuments')
$ps7ProfileDir = Join-Path $userDocuments "PowerShell"
$ps7ProfilePath = Join-Path $ps7ProfileDir "Microsoft.PowerShell_profile.ps1"

if (!(Test-Path -Path $ps7ProfileDir)) {
    Write-Output "Creating directory: $ps7ProfileDir"
    New-Item -ItemType Directory -Force -Path $ps7ProfileDir
}

Write-Output "Downloading profile to $ps7ProfilePath ..."
try {
    Invoke-WebRequest -Uri $pwshProfileUrl -OutFile $ps7ProfilePath -ErrorAction Stop
    Write-Output "Success!"
} catch {
    Write-Error "Failed to download profile: $_"
}

Write-Output ""
Write-Output "#"
Write-Output "# Setting up Starship Config..."
Write-Output "#"

$starshipConfigUrl = "https://raw.githubusercontent.com/shimosyan/setup/main/starship.toml"
$starshipConfigDir = Join-Path $HOME ".config"
$starshipConfigPath = Join-Path $starshipConfigDir "starship.toml"

if (!(Test-Path -Path $starshipConfigDir)) {
    New-Item -ItemType Directory -Force -Path $starshipConfigDir
}

Invoke-WebRequest -Uri $starshipConfigUrl -OutFile $starshipConfigPath
Write-Output "Starship config installed at $starshipConfigPath"

Write-Output ""
Write-Output "--- Setup Complete ---"
