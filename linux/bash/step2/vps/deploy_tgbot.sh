#!/bin/bash

# ubuntu18部署tgbot(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署tgbot..."

cd /root/code/docker/dockerfile_work/tgbot

# 启动tgbot
docker-compose up -d

echo "=========================================tgbot部署完成!"
