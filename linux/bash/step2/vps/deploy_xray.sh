#!/bin/bash

# ubuntu18部署xray(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署xray..."

# 提供配置服务 应用服务器不再提供
systemctl enable nginx
systemctl start nginx

# 启动xray
cd /root/code/docker/dockerfile_work/xray
docker-compose up -d

sudo cat <<EOF >/etc/nginx/passwdfile
$2:$3/
EOF
chmod 777 /etc/nginx/passwdfile

# 通过nginx发布xray客户端http服务

sudo cat <<EOF >/etc/nginx/nginx.conf
user root;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 2048;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

    server {
        listen 9999 ssl;
        server_name  $1;  # 配置文件
         # 注意文件位置，是从/etc/nginx/下开始算起的
        ssl_certificate /root/code/docker/dockerfile_work/xray/cert/fullchain.pem;
        ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/privkey.pem;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;   
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
        ssl_prefer_server_ciphers on;
        client_max_body_size 1024m; 
        
        location / {
            root /root/code/docker/dockerfile_work/xray/config;
            auth_basic "authentication";
            auth_basic_user_file /etc/nginx/passwdfile;
            autoindex on;
            charset utf-8; 
        }
        
    }
}


#mail {
#	# See sample authentication script at:
#	# http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#	# auth_http localhost/auth.php;
#	# pop3_capabilities "TOP" "USER";
#	# imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#	server {
#		listen     localhost:110;
#		protocol   pop3;
#		proxy      on;
#	}
# 
#	server {
#		listen     localhost:143;
#		protocol   imap;
#		proxy      on;
#	}
#}
EOF

systemctl daemon-reload
systemctl restart nginx
echo "=========================================xray部署完成!"
