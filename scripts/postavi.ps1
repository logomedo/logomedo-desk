# Postavljanje na Windowsu: submoduli + remote `upstream` u svakom forku. Pokretanje: powershell -File scripts\postavi.ps1
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")
git config core.longpaths true
git submodule update --init --recursive
Get-Content scripts\upstreami.txt | ForEach-Object {
  $put, $upstream = $_ -split " "
  if ((git -C $put remote) -contains "upstream") { git -C $put remote set-url upstream $upstream }
  else { git -C $put remote add upstream $upstream }
  Write-Host "$put -> upstream $upstream"
}
Write-Host "Gotovo. Alati i verzije: docs\forkovi.md, koraci: docs\plan.md"
