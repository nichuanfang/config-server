#!/bin/bash

# 配置ubuntu18的证书

echo "==========================================开始配置证书..."

# 安装python3-certbot-nginx
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python3-certbot-nginx

cd /root/code/certbot && gp
# 更改权限
chmod 777 au.sh


echo "==========================================证书配置完成!"
