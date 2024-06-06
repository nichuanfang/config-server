#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署bark_server..."

cd /root/code/docker/dockerfile_work/barkserver

docker-compose up -d

echo "=========================================bark_server部署完成!"
