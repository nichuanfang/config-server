#!/bin/bash

# 配置ubuntu18的docker环境

echo "==========================================开始配置docker环境..."

sudo apt-get install docker.io -y

echo "开始安装docker-compose..."

# 官方git地址下载
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 修改权限
chmod +x /usr/local/bin/docker-compose

echo "docker-compose安装完成!"

echo "==========================================docker环境配置完成!"
