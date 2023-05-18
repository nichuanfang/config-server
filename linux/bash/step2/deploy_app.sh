#!/bin/bash

# 部署ubuntu18的应用
echo "==========================================开始部署应用..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
# 禁止nginx
systemctl stop nginx
systemctl disable nginx
# 创建网络mynet
docker network create mynet

# 执行nginx初始化 $1: 域名
cd /root/code/docker && git checkout . && git pull --allow-unrelated-histories
/bin/bash /root/code/docker/dockerfile_work/nginx/init.sh
cd /root/code/docker/docker-compose
# 登录阿里云镜像仓库
docker login --username=$1 --password=$2 registry.cn-hangzhou.aliyuncs.com
# 启动服务
docker-compose up -d
echo "==========================================应用部署完成!"
