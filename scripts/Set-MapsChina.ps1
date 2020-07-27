#!/usr/bin/env powershell

echo "Setting ChinaVariant 1..."
$path = 'HKLM:\SYSTEM\Maps'
sp -path $path -name 'ChinaVariant' -value 1
sp -path $path -name 'OEMChinaVariantWin10' -value 1

echo "Now delete all maps, Get-AppxPackage *Maps* | Remove-AppxPackage and reboot"

