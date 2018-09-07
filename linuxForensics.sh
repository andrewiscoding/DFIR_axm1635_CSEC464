!/bin/bash

# time
date +"%T"
date + "%Z"
uptime

# os version
hostnamectl

# hardware
cat /proc/cpuinfo | grep vendor | unid
grep MemTotal /proc/meminfo
df

# hostname
hostname
domainname

# users
cut -d: -f1 /etc/passwd

# programs
initctl list
service --status-all

# network
arp -a
ifconfig /all
netstat -an

# processes
ps -A

# drivers
lspci -v

# documents and downloads
for entry in "$~/Downloads/*" and "$~/Documents/*"
do
  echo "$entry"
done

# iptables
sudo iptables -L

# view admins
sudo cat /etc/sudoers

# command history
history
