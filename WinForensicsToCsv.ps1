# Andrew McKenzie
# Windows Forensics Script
# Computer System Forensics

$filename = Read-Host -Prompt 'Input CVS file location: '

# Time
Get-Date | select DateTime | Out-File $filename
Get-TimeZone | select Id | Out-File -Append $filename
Get-CimInstance -ClassName win32_operatingsystem | select lastbootuptime | Out-File -Append $filename

# OS Version
[environment]::OSVersion.Version | Out-File -Append $filename
Get-WmiObject Win32_OperatingSystem | select Caption | Out-File -Append $filename

# System Hardware
Get-WmiObject Win32_processor | select Caption, Name | Out-File -Append $filename
Get-WmiObject -class "Win32_PhysicalMemoryArray" | select MaxCapacity | Out-File -Append $filename
[System.IO.DriveInfo]::GetDrives() | Out-File -Append $filename
Get-PSDrive -PSProvider FileSystem | Out-File -Append $filename

# Domain Controller
# These commands work in the case that the windows machine
# understands server side data
# Get-ADDomainController | select ipv4Address

# Hostname and Domain
$env:COMPUTERNAME | Out-File -Append $filename
(Get-WmiObject Win32_ComputerSystem).domain | Out-File -Append $filename

# Users
Get-WmiObject -Class Win32_UserAccount | select Caption | Out-File -Append $filename

# Start at boot

# Scheduled Tasks
(Get-ScheduledTask).TaskName | Out-File -Append $filename

# Network
Get-NetNeighbor -State Reachable | Out-File -Append $filename
Get-WmiObject win32_networkadapterconfiguration | select description, macaddress | Out-File -Append $filename
Get-NetRoute | Out-File -Append $filename
Get-NetIPAddress | select IPAddress, InterfaceAlias | Out-File -Append $filename
Get-WmiObject Win32_NetworkAdapterConfiguration | select DHCPServer | Out-File -Append $filename
Get-DnsClientServerAddress | select InterfaceAlias, ServerAddresses | Out-File -Append $filename
(Get-wmiObject Win32_networkAdapterConfiguration | ?{$_.IPEnabled}).DefaultIPGateway | Out-File -Append $filename
Get-NetTCPConnection -State Listen | Out-File -Append $filename
Get-NetTCPConnection -State Established | Out-File -Append $filename
Get-DnsClientCache | select Entry, Data | Out-File -Append $filename

# Network Shares
Get-SmbShare | Out-File -Append $filename

# Installed Software
Get-WmiObject -Class Win32_Product | select Name | Out-File -Append $filename

# Process List
Get-Process | Out-File -Append $filename

# Drivers (uncomment to list, will lengthen time of output)
# Get-WindowsDriver -Online -All | select Driver, BootCritical, OriginalFileName, Version, Date, ProviderName | Out-File -Append $filename

# Downloads and Documents

# Get firewall rules on public profile
Get-NetFirewallProfile -Name Public | Get-NetFirewallRule | Out-File -Append $filename

# Get administrators
net localgroup administrators | Out-File -Append $filename

# Get security logs
get-eventlog security -newest 10 | Out-File -Append $filename


