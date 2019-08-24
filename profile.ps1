if (!$env:path.contains("$env:UserProfile\bin")) {
  $env:path += ";$env:UserProfile\bin"
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

