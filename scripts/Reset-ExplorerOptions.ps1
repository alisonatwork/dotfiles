#!/usr/bin/env powershell

$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
@{
    DontPrettyPath               = 1
    Hidden                       = 1
    HideFileExt                  = 0
    NavPaneExpandToCurrentFolder = 1
    NavPaneShowAllFolders        = 0
    ShowSuperHidden              = 0
}.GetEnumerator() | foreach {
    echo "Setting $($_.key) $($_.value)..."
    sp -path $path -name $_.key -value $_.value
}
kill -processname explorer
