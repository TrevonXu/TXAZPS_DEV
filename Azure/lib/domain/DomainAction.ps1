# Copyright (c) 2012 Sage Software, Inc. All rights reserved.
#
#--------------------------------------------------------------------------------
# Objective:
#     1. Change DNS
#     2. Add Domain
#     3. Remove Domain
#1
#--------------------------------------------------------------------------------

# Stop and fail script when a command fails.
$ErrorActionPreference = "Stop"


#-------------------------------------------------------------------------------
#      Change DNS Server Address Of Local Host
#-------------------------------------------------------------------------------

Function ChangeDNS ([string]$dns, [string]$interfacealias)
{
   
      Set-DnsClientServerAddress -InterfaceAlias $interfacealias -ServerAddresses ($dns) 
}



#---------------------------------------------------------------------------------
#      Add local server to domain
#---------------------------------------------------------------------------------
Function JoinDomain ([string]$domain, [string]$oupath, [string]$user, [string]$password)
{
    
    $p = ConvertTo-SecureString  $password -AsPlainText -Force
    $c = New-Object System.Management.Automation.PSCredential $user, $p
    Add-Computer -DomainName $domain -OUPath $oupath  -Credential $c -Restart -Force

 }

 
#---------------------------------------------------------------------------------
#     Remove local server from domain
#---------------------------------------------------------------------------------
 Function RemoveDomain ([string]$domain, [string]$oupath, [string]$user, [string]$password)
{
    
    $p = ConvertTo-SecureString  $password -AsPlainText -Force
    $c = New-Object System.Management.Automation.PSCredential $user, $p
    Remove-Computer -Credential $c -Restart -Force

 }

ChangeDNS "192.168.1.4" "Ethernet"
JoinDomain "Sage300Cloud.adinternal.com" "OU=RDS,OU=Servers,DC=Sage300Cloud,DC=adinternal,DC=com" "Sage300Cloud\administrator" "sage.123"
#RemoveDomain "Sage300Cloud.adinternal.com" "OU=RDS,OU=Servers,DC=Sage300Cloud,DC=adinternal,DC=com" "Sage300Cloud\administrator" "sage.123"