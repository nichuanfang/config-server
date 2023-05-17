#!/bin/bash

# 配置ubuntu18的docker环境

echo "==========================================开始配置docker环境..."

# 安装软件包依赖
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# 在系统中添加Docker的官方密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 添加Docker源,选择stable长期稳定版
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# 再次更新源列表
sudo apt update

# 查看可以安装的Docker版本
sudo apt-cache policy docker-ce

# 开始安装Docker（ce表示社区版）
sudo apt install docker-ce -y

# 启动Docker服务
sudo systemctl start docker

# 设置开机自启动docker
sudo systemctl enable docker

# 查看Docker是否开启，出现绿色圆点表示服务正常开启
sudo systemctl status docker

echo "开始安装docker-compose..."

# 官方git地址下载
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# daocloud下载安装（速度快些）
curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) >/usr/local/bin/docker-compose
# 修改权限
chmod +x /usr/local/bin/docker-compose

echo "docker-compose安装完成!"

echo "==========================================docker环境配置完成!"
