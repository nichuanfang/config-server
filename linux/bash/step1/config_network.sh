#!/bin/bash

echo "==================================================操作系统网络配置相关脚本,开始执行....."

echo '本地主机名解析设置...'
sed -i "s/127.0.1.1\s.\w.*$/127.0.1.1 $1/g" /etc/hosts
grep -q "^\$(hostname -I)\s.\w.*$" /etc/hosts && sed -i "s/\$(hostname -I)\s.\w.*$/$2 $1" /etc/hosts || echo "$2 $1" >>/etc/hosts
cat /etc/hosts

echo '系统DNS域名解析服务设置...'
# cp -a /etc/resolv.conf{,.bak}
echo "nameserver 8.8.4.4" >>/etc/resolv.conf
echo "nameserver 223.5.5.5" >>/etc/resolv.conf
echo "nameserver 223.6.6.6" >>/etc/resolv.conf
cat /etc/resolv.conf
echo "==================================================操作系统网络配置完成!"
