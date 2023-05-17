#!/bin/bash

# 配置ubuntu18的node环境

echo "=========================================开始配置node环境..."
# 安装14.x版本的node和对应的npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
# 安装node和npm
apt install nodejs -y
echo "=========================================node环境配置完成!"
