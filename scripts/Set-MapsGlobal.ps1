#!/usr/bin/env powershell

echo "Setting ChinaVariant 0..."
$path = 'HKLM:\SYSTEM\Maps'
sp -path $path -name 'ChinaVariant' -value 0
sp -path $path -name 'OEMChinaVariantWin10' -value 0

echo "Now delete all maps, Get-AppxPackage *Maps* | Remove-AppxPackage and reboot"

