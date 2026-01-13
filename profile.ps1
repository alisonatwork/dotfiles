if (!$env:path.contains("$env:UserProfile\bin")) {
  $env:path = "$env:UserProfile\bin;$env:Path"
}

$Csc = gci "$env:windir\Microsoft.NET\Framework64\*\csc.exe" -ea silent | select -last 1
if ($Csc) {
  Set-Alias -Name csc -Value $Csc
  $Csc = $null
}

if ((Test-Path "$env:UserProfile\.config\rg\config") -and (gcm rg -ea silent)) {
  $env:RIPGREP_CONFIG_PATH = "$env:UserProfile\.config\rg\config"
}

if (Test-Path "$env:ProgramFiles\Git\usr\bin") {
  Set-Alias -Name bash -Value "$env:ProgramFiles\Git\usr\bin\bash.exe"
  $env:SHELL = "$env:ProgramFiles\Git\usr\bin\bash.exe"
  Set-Alias -Name vi -Value "$env:ProgramFiles\Git\usr\bin\vim.exe"
  Set-Alias -Name vim -Value "$env:ProgramFiles\Git\usr\bin\vim.exe"
}

if (gcm nvim.exe -ea silent) {
  function nvim {
    $env:TERM = "ansi"
    nvim.exe $args
    $env:TERM = $Null
  }
  Set-Alias -Name vi -Value nvim
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Import-Module -ea silent WSLTabCompletion
