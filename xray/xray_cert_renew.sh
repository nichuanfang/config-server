#!/bin/bash

/root/.acme.sh/acme.sh --issue -d "www.cinima.asia"  --server letsencrypt  --keylength ec-256  --fullchain-file /usr/local/etc/xray/cert.pem  --key-file /usr/local/etc/xray/key.pem  --standalone  --force
echo "Xray Certificates Renewed"

chmod +r /usr/local/etc/xray/key.pem
echo "Read Permission Granted for Private Key"

sudo systemctl restart xray
echo "Xray Restarted"
