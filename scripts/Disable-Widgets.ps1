#!/usr/bin/env powershell

echo "Setting IsPrelaunchEnabled 0..."
$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Dsh'
sp -path $path -name 'IsPrelaunchEnabled' -value 0
