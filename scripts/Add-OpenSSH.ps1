#!/usr/bin/env powershell

echo "Adding OpenSSH..."
Get-WindowsCapability -Online | where Name -like 'OpenSSH*' | where State -eq 'NotPresent' |
  foreach {
    Add-WindowsCapability -Online -Name $_.Name
  }

