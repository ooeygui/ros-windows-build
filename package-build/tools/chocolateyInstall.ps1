$ErrorActionPreference = 'Stop';

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'drop.zip'
$destination = 'c:\opt\ros'

$packageArgs = @{
  packageName   = $packageName
  destination   = $destination
  fileFullPath64  = $fileLocation
}

# - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
Get-ChocolateyUnzip @packageArgs

Write-Host 'running rosdep...'
$ErrorActionPreference = 'SilentlyContinue';
$rosdepInstall = Join-Path $toolsDir 'rosdepInstall.bat'
$p = Start-Process -FilePath "$env:comspec" -Wait -NoNewWindow -ArgumentList "/c", $rosdepInstall
If($p.Exitcode -ne 0)
{
  Throw "rosdepInstall.bat failed."
}
