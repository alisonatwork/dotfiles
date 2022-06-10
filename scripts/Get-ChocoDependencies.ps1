#!/usr/bin/env powershell

# See https://github.com/chocolatey/choco/issues/1276

$packages = gci C:\ProgramData\chocolatey\lib\ -Recurse  *.nuspec | select fullname, name 
foreach ($p in $packages) {
  [XML]$xml = cat $p.fullname
  $dependencies = $xml.package.metadata.dependencies.dependency
  foreach ($d in $dependencies) {
    $obj = New-Object -TypeName psobject
    $obj | Add-Member -MemberType NoteProperty -name package -value $xml.package.metadata.id
    $obj | Add-Member -MemberType NoteProperty -name packageversion -value $xml.package.metadata.version
    $obj | Add-Member -MemberType NoteProperty -name dependency -value  $d.id
    $obj | Add-Member -MemberType NoteProperty -name dependencyversion -value  $d.version
    $obj
  }
}
