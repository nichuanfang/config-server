#!/bin/bash

# 更新ubuntu18的证书

echo "================================================开始更新证书..."
docker stop nginx
certbot renew --cert-name $1 --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
cp /etc/letsencrypt/live/$1/fullchain.pem /opt/docker/nginx/cert
cp /etc/letsencrypt/live/$1/privkey.pem /opt/docker/nginx/cert
echo "Certificates Renewed"
chmod 777 /opt/docker/nginx/cert/*.pem
echo "Read Permission Granted for Private Key"
docker start nginx
echo "================================================证书更新完成!"
