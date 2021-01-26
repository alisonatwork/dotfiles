#!/usr/bin/env powershell

$DnsCryptProxyDir = "$env:ChocolateyInstall\lib\dnscrypt-proxy\tools\win64"
if (Test-Path($DnsCryptProxyDir)) {
  echo "Downloading latest mybase..."
  iwr https://download.dnscrypt.info/blacklists/domains/mybase.txt -OutFile "$env:TEMP\mybase.txt"
  net stop dnscrypt-proxy
  echo "Replacing $DnsCryptProxyDir\mybase.txt"
  del "$DnsCryptProxyDir\mybase.txt.old"
  move "$DnsCryptProxyDir\mybase.txt" "$DnsCryptProxyDir\mybase.txt.old"
  move "$env:TEMP\mybase.txt" "$DnsCryptProxyDir\mybase.txt"
  net start dnscrypt-proxy
} else {
  echo "Can't find dnscrypt-proxy at $DnsCryptProxyDir"
}

