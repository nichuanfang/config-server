#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署ChatgptNextWeb..."

# 存放cookies.txt  防止有些视频无法下载
cd /root/code/docker/dockerfile_work/chatgpt_next_web || exit

# 开放3000端口
docker-compose up -d

echo "=========================================ChatgptNextWeb部署成功!"
