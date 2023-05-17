#!/bin/bash

# 配置ubuntu20的网络
HOSTNAME=$1
# HOSTNAME=www.vencenter.cn
IPADDR=$2
# IPADDR=38.55.97.97

echo "==================================================操作系统网络配置相关脚本,开始执行....."
# (1) 本地主机名解析设置
sed -i "s/127.0.1.1\s.\w.*$/127.0.1.1 ${HOSTNAME}/g" /etc/hosts
grep -q "^\$(hostname -I)\s.\w.*$" /etc/hosts && sed -i "s/\$(hostname -I)\s.\w.*$/${IPADDR} ${HOSTNAME}" /etc/hosts || echo "${IPADDR} ${HOSTNAME}" >>/etc/hosts

# (2) 系统DNS域名解析服务设置
# cp -a /etc/resolv.conf{,.bak}
echo "nameserver 8.8.4.4" >>/etc/resolv.conf
echo "nameserver 223.5.5.5" >>/etc/resolv.conf
echo "nameserver 223.6.6.6" >>/etc/resolv.conf
echo "==================================================操作系统网络配置完成!"
