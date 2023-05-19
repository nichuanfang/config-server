#!/bin/bash

# 更新ubuntu18的证书

echo "================================================开始更新证书..."
docker stop nginx
cd /root/code/docker/dockerfile_work/nginx/cert/
git checkout . && git pull
certbot renew --cert-name $1 --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
cp -f /etc/letsencrypt/live/$1/fullchain.pem /opt/docker/nginx/cert/cert.pem
cp -f /etc/letsencrypt/live/$1/privkey.pem /opt/docker/nginx/cert/key.pem
echo "Certificates Renewed"
chmod 777 /opt/docker/nginx/cert/*.pem
cp -r /opt/docker/nginx/cert/*.pem /root/code/docker/dockerfile_work/nginx/cert/
git add .
git commit "更新站点:${1}nginx证书"
git push
echo "Read Permission Granted for Private Key"
docker start nginx
echo "================================================证书更新完成!"
