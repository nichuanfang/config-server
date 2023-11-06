#!/bin/bash

# ubuntu18部署rathole服务端(内网穿透服务)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署rathole服务端..."

cd /root/code/docker/dockerfile_work/rathole/server

docker-compose up -d

echo "=========================================rathole服务端部署完成!"
