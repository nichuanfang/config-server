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

# 优化linux内核
cat > /etc/sysctl.conf << EOF
net.core.somaxconn = 65535
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_notsent_lowat=16384
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_max_tw_buckets = 50000
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
EOF

sysctl -p
# sudo systemctl daemon-reload
# sudo systemctl stop systemd-resolved
# sudo systemctl start systemd-resolved
# systemd-resolve --status
echo "==================================================操作系统网络配置完成!"
