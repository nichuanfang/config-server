#!/bin/bash

# 部署ubuntu18的应用
echo "==========================================开始部署应用..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
mkdir -p /root/code && cd /root/code
cd /root/code/docker/docker-compose
# 创建网络mynet
docker network create mynet
# 启动服务
docker-compose up -d
echo "==========================================应用部署完成!"
