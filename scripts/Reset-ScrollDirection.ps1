#!/usr/bin/env powershell

echo "Setting FlipFlopWheel 1..."
$glob = 'HKLM:\SYSTEM\CurrentControlSet\Enum\HID\VID*\*\Device Parameters'
gp -path $glob -name 'FlipFlopWheel' -ea silent |
  foreach {
    echo ($_.pspath -replace '^.*::','')
    sp -path $_.pspath -name 'FlipFlopWheel' -value 1
  }

