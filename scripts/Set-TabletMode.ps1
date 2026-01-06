#!/usr/bin/env powershell

echo "Setting ConvertibleSlateMode 0..."
$path = 'HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl'
sp -path $path -name 'ConvertibleSlateMode' -value 0
