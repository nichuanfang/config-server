#!/bin/bash

# ubuntu18部署metube(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署bark_server..."

mkdir bark-server && cd bark-server
curl -sL https://raw.githubusercontent.com/Finb/bark-server/master/deploy/docker-compose.yaml >docker-compose.yaml
docker-compose up -d

echo "=========================================bark_server部署完成!"
