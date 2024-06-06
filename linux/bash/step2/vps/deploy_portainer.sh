#!/bin/bash

# ubuntu18部署portainer(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署portainer..."

cd /root/code/docker/dockerfile_work/portainer

docker-compose up -d

echo "=========================================portainer部署完成!"
