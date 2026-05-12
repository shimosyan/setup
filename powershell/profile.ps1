#
# PowerShell Profile
#

#
# Starship
#
Invoke-Expression (&starship init powershell)

#
# Zoxide
#
Invoke-Expression (& { (zoxide init powershell | Out-String) })

#
# eza
#
if (Test-Path Alias:ls) { Remove-Item Alias:ls -Force } # Remove ls Alias
function ls { eza --icons --group-directories-first @args }
function ll { eza -la --icons --group-directories-first --git @args }
function lt { eza --tree --level=2 --icons @args }

#
# PSReadLine
#
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
