#!/bin/bash

# 配置ubuntu18的node环境

echo "=========================================开始配置node环境..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
# 安装14.x版本的node和对应的npm
curl -sL https://deb.nodesource.com/setup_18.x | sudo bash -

# 安装node和npm
sudo apt-get install -y nodejs

echo "=========================================node环境配置完成!"
