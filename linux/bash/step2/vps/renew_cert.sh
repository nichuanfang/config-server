#!/bin/bash

# 更新ubuntu18的证书
certbot renew --cert-name $1 --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
cp -f /etc/letsencrypt/live/$1/fullchain.pem /root/code/docker/dockerfile_work/xray/cert/cert.pem
cp -f /etc/letsencrypt/live/$1/privkey.pem /root/code/docker/dockerfile_work/xray/cert/key.pem
echo "Certificates Renewed"
chmod 777 /root/code/docker/dockerfile_work/xray/cert/*.pem
cd /root/code/docker/dockerfile_work/xray/cert/
git add .
git commit -m "证书已更新"
git push
echo "Read Permission Granted for Private Key"
docker restart xray
