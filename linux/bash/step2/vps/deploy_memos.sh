#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署memos..."

cd /root/code/docker/dockerfile_work/memos || exit

docker-compose up -d

echo "=========================================memos部署完成!"
