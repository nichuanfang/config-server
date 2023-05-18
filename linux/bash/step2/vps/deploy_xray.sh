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

# 启动xray
cd /root/code/docker/dockerfile_work/xray
docker-compose up -d

# 通过nginx发布xray客户端http服务
# todo...

echo "=========================================xray部署完成!"
