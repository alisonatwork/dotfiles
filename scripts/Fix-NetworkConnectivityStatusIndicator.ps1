#!/usr/bin/env powershell

echo "Setting UseGlobalDNS 1..."
$path = 'HKLM:\SOFTWARE\POLICIES\MICROSOFT\Windows\NetworkConnectivityStatusIndicator'
sp -path $path -name 'UseGlobalDNS' -value 1
