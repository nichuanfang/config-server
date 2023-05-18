#!/bin/bash

# 配置ubuntu18的证书

echo "==========================================开始配置证书..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
# 安装python3-certbot-nginx
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot --yes
sudo apt-get update
sudo apt-get install python3-certbot-nginx -y

cd /root/code/certbot && git checkout . && git pull --allow-unrelated-histories

certbot certonly -m $1@gmail.com -n --agree-tos --manual-public-ip-logging-ok -d *.$2 --manual --preferred-challenges dns --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
# 验证证书
# cat /etc/letsencrypt/live/$2/cert.pem
# 证书的保存目录
mkdir -p /opt/docker/nginx/cert
cp /etc/letsencrypt/live/$2/fullchain.pem /opt/docker/nginx/cert
cp /etc/letsencrypt/live/$2/privkey.pem /opt/docker/nginx/cert
chmod 777 /opt/docker/nginx/cert/*.pem
echo "==========================================证书配置完成!"
