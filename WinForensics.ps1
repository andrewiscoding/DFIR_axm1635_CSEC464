
# Andrew McKenzie
# Windows Forensics Script
# Computer System Forensics

# Import-Module ActiveDirectory

# Time
Get-Date
Get-TimeZone | select Id
Get-CimInstance -ClassName win32_operatingsystem | select lastbootuptime

# OS Version
[environment]::OSVersion.Version
(Get-WmiObject Win32_OperatingSystem).Caption

# System Hardware
Get-WmiObject Win32_processor | select Caption, Name
Get-WmiObject -class "Win32_PhysicalMemoryArray" | select MaxCapacity
[System.IO.DriveInfo]::GetDrives()
Get-PSDrive -PSProvider FileSystem

# Domain Controller
# Get-ADDomainController | select ipv4Address

# Hostname and Domain
hostname
(Get-WmiObject Win32_ComputerSystem).domain

# Users
Get-WmiObject -Class Win32_UserAccount | select Caption

# Start at boot

# Scheduled Tasks
(Get-ScheduledTask).TaskName

# Network
arp -a
Get-WmiObject win32_networkadapterconfiguration | select description, macaddress
Get-NetRoute
Get-NetIPAddress | select IPAddress, InterfaceAlias
Get-WmiObject Win32_NetworkAdapterConfiguration | select DHCPServer
Get-DnsClientServerAddress | select InterfaceAlias, ServerAddresses
(Get-wmiObject Win32_networkAdapterConfiguration | ?{$_.IPEnabled}).DefaultIPGateway
Get-NetTCPConnection -State Listen
Get-NetTCPConnection -State Established
Get-DnsClientCache | select Entry, Data

# Network Shares
net view

# Installed Software
Get-WmiObject -Class Win32_Product | select Name

# Process List
Get-Process

# Drivers
Get-WindowsDriver -Online -All | select Driver, BootCritical, OriginalFileName, Version, Date, ProviderName

# Downloads and Documents

# Get firewall rules on public profile
Get-NetFirewallProfile -Name Public | Get-NetFirewallRule

# Get administrators
net localgroup administrators

# Get security logs
get-eventlog security -newest 10

