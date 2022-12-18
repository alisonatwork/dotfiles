#!/usr/bin/env powershell

echo "Setting DisableSearchBoxSuggestions 1..."
$path = 'HKCU:\Software\Policies\Microsoft\Windows\Explorer'
sp -path $path -name 'DisableSearchBoxSuggestions' -value 1
