#!/bin/bash

# ubuntu18部署waline(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署waline..."

cd /root/code/docker/dockerfile_work/waline

mkdir -p /root/waline/data
# 将当前文件夹的waline.sqlite拷贝到/root/waline/data
cp -f ./waline.sqlite /root/waline/data

# 启动waline
docker-compose up -d

echo "=========================================waline部署完成!"
