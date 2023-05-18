#!/bin/bash

# 配置ubuntu18的证书

echo "==========================================开始配置证书..."

cd /root/code/certbot && gp
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python3-certbot-nginx

echo "==========================================证书配置完成!"
