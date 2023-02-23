#!/bin/bash

systemctl stop nginx

/root/.acme.sh/acme.sh --issue \
		-d "$0" \
		--server letsencrypt \
		--keylength ec-256 \
		--fullchain-file /usr/local/etc/xray/cert.pem \
		--key-file /usr/local/etc/xray/key.pem \
		--standalone \
		--force 
    
echo "Xray Certificates Renewed"

chmod 600 /usr/local/etc/xray/*.pem

echo "Read Permission Granted for Private Key"

systemctl start nginx
sudo systemctl restart xray

echo "Xray Restarted"
