#!/usr/bin/env powershell

echo "Setting ParsingName absolute..."
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions'
@(
    '{374DE290-123F-4565-9164-39C4925E467B}', # Downloads
    '{7d83ee9b-2244-4e70-b1f5-5393042af1e4}'  # Local Downloads
) | % { gp -path $path\$_ } | foreach {
    echo "$($_.Name) ($($_.RelativePath)): $($_.pspath -replace '^.*::','')"
    sp -path $_.pspath -name 'ParsingName' -value ($_.ParsingName -replace '^(shell:)?::', '')
    sp -path $_.pspath -name 'ParsingName_36354489' -value ($_.ParsingName_36354489 -replace '^(shell:)?::', '')
}
echo "Now reboot"
