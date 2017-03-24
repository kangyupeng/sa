## Introduction
1. A主机，公网IP， sshd端口2221
2. B主机，内网10.0.0.1， sshd端口2223

目的: 使内网B主机可以通过A主机登录

## Procedure
### 1. 配置B公钥免密登录A
### 2. 将123.123.123.123:1234 映射为10.0.0.1：2223
```
1. ssh -NfR 1234:localhost:2223 user1@123.123.123.123 -p2221
2. ssh -p1234 root@123.123.123.123可登录B主机
```
### 3. 
```
autossh -M 5678 -NR 1234:localhost:2223 user1@123.123.123.123 -p2221

-M 5678: 通过5678端口监视链接状态， 有问题自动重连
```