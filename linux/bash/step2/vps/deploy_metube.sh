#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署metube..."

# 存放临时下载文件目录
mkdir -p ~/data/metube/downloads
# 存放cookies.txt  防止有些视频无法下载
mkdir -p ~/data/metube/cookies
cd ~/code/docker/dockerfile_work/metube

# 开放9999端口
docker-compose up -d

echo "=========================================metube部署完成!"
