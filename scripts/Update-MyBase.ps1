#!/usr/bin/env powershell

$DnsCryptProxyDir = "C:\Program Files\WinGet\Packages\DNSCrypt.dnscrypt-proxy_Microsoft.Winget.Source_8wekyb3d8bbwe\win64"
$MyBaseDownload = "$env:TEMP\mybase.txt"
if (Test-Path($DnsCryptProxyDir)) {
  echo "Downloading latest mybase..."
  iwr https://download.dnscrypt.info/blacklists/domains/mybase.txt -OutFile $MyBaseDownload
  echo "Stopping dnscrypt-proxy..."
  spsv dnscrypt-proxy
  if (Test-Path($MyBaseDownload)) {
    echo "Replacing $DnsCryptProxyDir\mybase.txt"
    move -force "$DnsCryptProxyDir\mybase.txt" "$DnsCryptProxyDir\mybase.txt.old"
    move $MyBaseDownload "$DnsCryptProxyDir\mybase.txt"
  }
  echo "Starting dnscrypt-proxy..."
  sasv dnscrypt-proxy
} else {
  echo "Can't find dnscrypt-proxy at $DnsCryptProxyDir"
}
