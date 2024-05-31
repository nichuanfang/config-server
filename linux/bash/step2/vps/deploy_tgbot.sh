#!/bin/bash

# ubuntu18部署telegram bot(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署telegram bot..."

cd /root/code/telegram-bot

# 启动telegram bot
docker-compose -f docker-compose.local.yml up -d

echo "=========================================telegram bot部署完成!"
