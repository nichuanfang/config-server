#!/bin/bash

# 部署koel(包括mysql)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署koel..."

# 创建网络
docker network create --attachable mynet

# 准备mysql服务

# 存放mysql数据和日志
mkdir -p /root/mysql/data
mkdir -p /root/mysql/log
chmod -R 777 /root/mysql

cd /root/code/docker/dockerfile_work/mysql
docker-compose up -d

# 准备koel服务
mkdir -p /root/koel/index
mkdir -p /root/koel/music
mkdir -p /root/koel/music/__KOEL_UPLOADS__
chmod -R 777 /root/koel

cd /root/code/docker/dockerfile_work/koel
docker-compose up -d

# 初始化
docker exec --user www-data -it koel php artisan koel:init --no-assets
# 修改密码
# docker exec -it koel php artisan koel:admin:change-password

echo "=========================================koel部署完成!"
