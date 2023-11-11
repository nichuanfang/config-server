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

# cat /dev/null >/etc/systemd/resolved.conf

# 修改默认dns为1.1.1.1
cat <<EOF >/etc/systemd/resolved.conf
[Resolve]
#DNS=
DNS=1.1.1.1
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=no-negative
#DNSStubListener=yes
#ReadEtcHosts=yes
# EOF

systemctl restart systemd-resolved.service

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
