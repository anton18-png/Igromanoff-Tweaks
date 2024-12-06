##########
# [USB] DISABLE_POWERSAVING - Script
# Author:	St1cky
# Website:	https://github.com/St1ckys
#
##########

$ErrorActionPreference = 'SilentlyContinue'
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force

$devicesUSB = Get-PnpDevice | where {$_.InstanceId -like "*USB\ROOT*"}  | 
ForEach-Object -Process {
Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root\wmi 
}

#To disable Power Management
foreach ( $device in $devicesUSB )
{
    Set-CimInstance -Namespace root\wmi -Query "SELECT * FROM MSPower_DeviceEnable WHERE InstanceName LIKE '%$($device.PNPDeviceID)%'" -Property @{Enable=$False} -PassThru
}
