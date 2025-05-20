#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署bitwarden..."

# 存放bitwarden备份文件目录
mkdir -p ~/data/bitwarden
cd /root/code/docker/dockerfile_work/bitwarden

# 恢复备份数据
cp -rf /root/code/bitwarden-backup/* ~/data/bitwarden
# 启动bitwarden 禁止出了主用户之外的新用户注册
docker-compose up -d

echo "=========================================bitwarden部署完成!"
