#!/bin/bash

echo "==================================================操作系统网络配置相关脚本,开始执行....."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend

sudo apt-get install iftop -y

echo '本地主机名解析设置...'
sed -i "s/127.0.1.1\s.\w.*$/127.0.1.1 $1/g" /etc/hosts
grep -q "^\$(hostname -I)\s.\w.*$" /etc/hosts && sed -i "s/\$(hostname -I)\s.\w.*$/$2 $1" /etc/hosts || echo "$2 $1" >>/etc/hosts
cat /etc/hosts

# 注: dns修改不生效 遂放弃
# echo '系统DNS域名解析服务设置...'

# cat /dev/null >/etc/resolv.conf

# cat <<EOF >/etc/resolv.conf
# nameserver 127.0.0.1
# options edns0
# search localdomain
# nameserver 8.8.4.4
# nameserver 223.5.5.5
# nameserver 223.6.6.6
# EOF

# cat /dev/null >/etc/NetworkManager/NetworkManager.conf
# cat <<EOF >/etc/NetworkManager/NetworkManager.conf

# [main]
# plugins=ifupdown,keyfile
# dns=none

# [ifupdown]
# managed=false

# [device]
# wifi.scan-rand-mac-address=no

# EOF

# sudo systemctl daemon-reload
# sudo systemctl stop systemd-resolved
# sudo systemctl start systemd-resolved
# systemd-resolve --status
echo "==================================================操作系统网络配置完成!"
