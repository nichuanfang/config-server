#!/bin/bash

# ubuntu18部署xray(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署xray..."

# 提供配置服务 应用服务器不再提供
systemctl enable nginx
systemctl start nginx

printf "$2:$(openssl passwd -crypt $3)\n" >>/etc/nginx/passwdfile
chmod 777 /etc/nginx/passwdfile

# 开启bbr加速 (ubuntu18.04)
echo "net.core.default_qdisc=fq" >>/etc/sysctl.conf
echo net.ipv4.tcp_congestion_control=bbr >>/etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control

# 检测BBR是否开启
lsmod | grep bbr

# 内核参数优化
# wget https://gist.githubusercontent.com/taurusxin/a9fc3ad039c44ab66fca0320045719b0/raw/3906efed227ee14fc5b4ac8eb4eea8855021ef19/optimize.sh && sudo bash optimize.sh 

# 启动xray
cd /root/code/docker/dockerfile_work/xray
docker-compose up -d

echo "=========================================xray部署完成!"
