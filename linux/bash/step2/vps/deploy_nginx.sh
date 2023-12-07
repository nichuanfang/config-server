#!/bin/bash

# ubuntu18部署nginx(vps专用)
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
echo "=========================================开始部署nginx..."

sudo apt-get --purge remove nginx -y
sudo apt-get autoremove

# 升级nginx
echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key

sudo apt install nginx -y

# 提供配置服务 应用服务器不再提供
systemctl enable nginx
systemctl start nginx

printf "$2:$(openssl passwd -crypt $3)\n" >>/etc/nginx/passwdfile
chmod 777 /etc/nginx/passwdfile

# 通过nginx发布xray客户端http服务
sudo cat <<EOF >/etc/nginx/nginx.conf
user root;
worker_processes 1;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 1024;
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
	

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	# gzip
	# gzip
	gzip on;
	gzip_min_length 1k;
	gzip_buffers 4 16k;
	#gzip_http_version 1.0;
	gzip_comp_level 2;
	gzip_types text/plain application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png image/webp font/woff2;
	gzip_vary off;
	gzip_disable "MSIE [1-6]\.";
	# Virtual Host Configs
	
	set_real_ip_from 127.0.0.1;
	real_ip_header proxy_protocol;

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
	
	# 防窥探服务
	server {
		listen 127.0.0.1:5001 proxy_protocol default_server;
		listen 127.0.0.1:5002 proxy_protocol default_server http2;

		location / {
			resolver 1.1.1.1;
			set \$example https://password.$1;
			proxy_pass \$example;
			proxy_ssl_server_name on;
			
		}
	}
	
	# xray自己偷自己
	server {
		listen 5555 proxy_protocol ssl http2 proxy_protocol;
		
		# SSL Settings
		##
		#ssl on;
		# 注意文件位置，是从/etc/nginx/下开始算起的
		#ssl证书的pem文件路径
		ssl_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		#ssl证书的key文件路径
		ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/key.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
		ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
		ssl_protocols TLSv1.2 TLSv1.3;
		ssl_stapling on;
		ssl_stapling_verify on;
		ssl_trusted_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		ssl_prefer_server_ciphers on;
		ssl_session_cache shared:SSL:10m;
		ssl_verify_depth 10;
		# ssl_reject_handshake    on;
		ssl_session_timeout     1h;
		ssl_early_data          on;

		location / {
			resolver 1.1.1.1;
			set \$example https://password.$1;
			proxy_pass \$example;
			proxy_ssl_server_name on;
			
		}
	}

	# xray配置服务器
	server {
		listen 5003 proxy_protocol;
		listen 5004  proxy_protocol http2;
		
		server_name  www.$1;

		# SSL Settings
		##
		#ssl on;
		# 注意文件位置，是从/etc/nginx/下开始算起的
		#ssl证书的pem文件路径
		ssl_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		#ssl证书的key文件路径
		ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/key.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
		ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
		ssl_protocols TLSv1.2 TLSv1.3;
		ssl_stapling on;
		ssl_stapling_verify on;
		ssl_trusted_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		ssl_prefer_server_ciphers on;
		ssl_session_cache shared:SSL:10m;
		ssl_verify_depth 10;
		# ssl_reject_handshake    on;
		ssl_session_timeout     1h;
		ssl_early_data          on;

  		default_type application/octet-stream;

  	


		# 静态站点
		location / {
			autoindex on;
			autoindex_exact_size off;
			autoindex_localtime on;
			auth_basic "authentication";
			auth_basic_user_file /etc/nginx/passwdfile;
			charset utf-8;
			root /root/code/docker/dockerfile_work/xray/config;
		}

	}
	
	# 自建密码平台Bitwarden
	server {
		listen 5005 proxy_protocol;
		listen 5006  proxy_protocol http2;
		
		server_name password.$1;

		##
		# SSL Settings
		##
		#ssl on;
		# 注意文件位置，是从/etc/nginx/下开始算起的
		#ssl证书的pem文件路径
		ssl_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		#ssl证书的key文件路径
		ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/key.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
		ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
		ssl_protocols TLSv1.2 TLSv1.3;
		ssl_stapling on;
		ssl_stapling_verify on;
		ssl_trusted_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		ssl_prefer_server_ciphers on;
		ssl_session_cache shared:SSL:10m;
		ssl_verify_depth 10;
		# ssl_reject_handshake    on;
        ssl_session_timeout     1h;
        ssl_early_data          on;


		# 这里配置拒绝访问的目录或文件
		# location ~ (repos) 
		# {
		#     deny all;
		# }

		#bitwarden
		location / {
			proxy_pass http://127.0.0.1:7006;
			proxy_set_header Host \$host;
			proxy_set_header X-Real-IP \$remote_addr;
			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
			proxy_set_header X-Forwarded-Proto \$scheme;
		}

		location /notifications/hub {
			proxy_pass http://127.0.0.1:7007;
			proxy_set_header Upgrade \$http_upgrade;
			proxy_set_header Connection "upgrade";
		}

		location /notifications/hub/negotiate {
			proxy_pass http://127.0.0.1:7006;
		}
	}

	# bark server
	server {
		listen 5007 proxy_protocol;
		listen 5008  proxy_protocol http2;
		
		server_name bark.$1;

		##
		# SSL Settings
		##
		#ssl on;
		# 注意文件位置，是从/etc/nginx/下开始算起的
		#ssl证书的pem文件路径
		ssl_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		#ssl证书的key文件路径
		ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/key.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
		ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
		ssl_protocols TLSv1.2 TLSv1.3;
		ssl_stapling on;
		ssl_stapling_verify on;
		ssl_trusted_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
		ssl_prefer_server_ciphers on;
		ssl_session_cache shared:SSL:10m;
		ssl_verify_depth 10;
		# ssl_reject_handshake    on;
        ssl_session_timeout     1h;
        ssl_early_data          on;


		# 这里配置拒绝访问的目录或文件
		# location ~ (repos) 
		# {
		#     deny all;
		# }

		# bark服务
		location / {
			proxy_connect_timeout 10;
			proxy_read_timeout 1d;
			proxy_send_timeout 1d;
			proxy_set_header Connection "";
			proxy_request_buffering off;
			proxy_pass_request_body off;
			proxy_redirect off;
			proxy_buffering off;
			proxy_http_version 1.1;
			proxy_set_header Upgrade \$http_upgrade;
			proxy_set_header Connection "upgrade";
			proxy_set_header Host \$http_host;
			proxy_set_header X-Real-IP \$remote_addr;
			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
			proxy_pass http://127.0.0.1:8080/;
		}
	}
 
 	server {
		listen 80;
		server_name jaychou.site *.jaychou.site;
		if ( \$host = "$1" ) {
			rewrite ^/(.*)$ http://www.$1\$1 permanent;
			return 200;
		}
		rewrite ^(.*)$ https://$host\$1 permanent;
	}
}
EOF
systemctl daemon-reload
systemctl restart nginx

echo "=========================================nginx部署完成!"
