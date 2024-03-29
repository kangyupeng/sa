#!/bin/bash

#/sbin/modprobe ip_conntrack_ftp
/sbin/iptables -F

#deny foreign-ip
/sbin/iptables -A INPUT -s 112.204.205.250 -j DROP 
/sbin/iptables -A INPUT -s 187.34.216.253 -j DROP 
/sbin/iptables -A INPUT -s 187.101.27.11 -j DROP 
/sbin/iptables -A INPUT -s 180.151.4.143 -j DROP
/sbin/iptables -A INPUT -s 14.99.223.141 -j DROP 
/sbin/iptables -A INPUT -s 112.203.220.195 -j DROP 
/sbin/iptables -A INPUT -s 1.220.109.75 -j DROP 
/sbin/iptables -A INPUT -s 187.59.82.238 -j DROP

#deny cn-ip
#/sbin/iptables -A INPUT -s 124.74.214.0/24 -j DROP
#/sbin/iptables -A INPUT -s 124.74.208.0/24 -j DROP
#/sbin/iptables -A INPUT -s 222.73.105.199 -j DROP
#/sbin/iptables -A INPUT -s 183.31.149.111 -j DROP
#/sbin/iptables -A INPUT -s 123.150.186.80 -j DROP

#personal_reserve deny ip

#another_add


#/sbin/sysctl -p
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#add your service here if need ...............
/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT

#/sbin/iptables -A INPUT -p tcp --dport 443 -j ACCEPT
### for liangchanglin


/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT


# Private network
/sbin/iptables -A INPUT -s 10.0.0.0/8 -j ACCEPT
/sbin/iptables -A INPUT -s 172.16.0.0/16 -j ACCEPT
/sbin/iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT
/sbin/iptables -A INPUT -s 10.8.64.64 -j ACCEPT

/sbin/iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

#for office out:
/sbin/iptables -A INPUT -p tcp -s 203.110.179.196 -j ACCEPT
#out port 2
/sbin/iptables -A INPUT -p tcp -s 61.172.254.80/29 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 203.110.164.200/29 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 202.108.48.131 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 1.202.140.162 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 119.57.160.183  -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 211.144.203.186/29 -j ACCEPT



#for IDC
/sbin/iptables -A INPUT -s 222.73.16.111/25  -j ACCEPT
#/sbin/iptables -A INPUT -s 222.73.19.171/24  -j ACCEPT
/sbin/iptables -A INPUT -s 114.80.215.167/24 -j ACCEPT

#for izaojiao access ftp:
/sbin/iptables -A INPUT -p tcp -s 180.168.34.26 -j ACCEPT

#for ossh:

#for outermonitor:

# for syslog monitor: 
#/sbin/iptables -A INPUT -p udp -s syslog-server-ip --sport 38514 -j ACCEPT

#for nagios monitor
/sbin/iptables -A INPUT -p tcp -s 222.73.19.224  -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 192.168.0.224  -j ACCEPT
#for cacti monitor
/sbin/iptables -A INPUT -p tcp -s 10.8.2.45  -j ACCEPT

#for net-snmp monitor:
#/sbin/iptables -A INPUT -p udp -s net-snmp-ip  --dport 161 -j ACCEPT

#drop control ports
#default drop other data
/sbin/iptables -P INPUT DROP
