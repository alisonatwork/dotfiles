#!/usr/bin/env powershell

$DnsCryptProxyDir = "$env:ProgramFiles\DNSCrypt"
$MyBaseDownload = "$env:TEMP\mybase.txt"
if (Test-Path $DnsCryptProxyDir) {
  echo "Downloading latest mybase..."
  iwr https://download.dnscrypt.info/blacklists/domains/mybase.txt -OutFile $MyBaseDownload
  echo "Stopping dnscrypt-proxy..."
  spsv dnscrypt-proxy
  if (Test-Path $MyBaseDownload) {
    echo "Replacing $DnsCryptProxyDir\mybase.txt"
    move -force "$DnsCryptProxyDir\mybase.txt" "$DnsCryptProxyDir\mybase.txt.old"
    move $MyBaseDownload "$DnsCryptProxyDir\mybase.txt"
  }
  echo "Starting dnscrypt-proxy..."
  sasv dnscrypt-proxy
} else {
  echo "Can't find dnscrypt-proxy at $DnsCryptProxyDir"
}
