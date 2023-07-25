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

printf "$2:$(openssl passwd -crypt $3)\n" >>/etc/nginx/passwdfile
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

    	# xray配置服务器
	server {
		listen 443 ssl http2 default_server;
		server_name  $1 www.$1;
		
		##
		# SSL Settings
		##
		ssl on;
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
		ssl_session_cache shared:SSL:1m;
		ssl_verify_depth 10;
		ssl_session_timeout 30m;
			
			
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
			
	        # 静态文件的过期时间，可以不需要此配置
	        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|js|css)$ {
			expires      30d;
			error_log off;
			access_log /dev/null;
		}
			
	    	# 这里很重要! 将日志转发到 /dev/stdout ，可以通过 docker logs -f  来查看容器日志
	        # access_log  /dev/stdout;
			
	}
	
	# 个人博客
	server {
        	listen 443 ssl http2;
		server_name blog.$1;
		
		##
		# SSL Settings
		##
		ssl on;
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
		ssl_session_cache shared:SSL:1m;
		ssl_verify_depth 10;
		ssl_session_timeout 30m;
		
		# 博客站点
		location / {
			charset utf-8;
			# 博客存放根目录
			root /root/blog;
			index  index.html index.htm; 
		}
    	}
	
	# bark server
	server {
        	listen 443 ssl http2;
		server_name bark.$1;
		
		##
		# SSL Settings
		##
		ssl on;
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
		ssl_session_cache shared:SSL:1m;
		ssl_verify_depth 10;
		ssl_session_timeout 30m;
		
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
			proxy_set_header Upgrade $http_upgrade;
			proxy_set_header Connection "upgrade";
			proxy_set_header Host $http_host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_pass http://127.0.0.1:8080/;
		}
    	}
	
	server {
		listen 80;
		server_name $1 *.$1;
		#将请求转成https
		rewrite ^(.*)$ https://$host$1 permanent;
	}
}
EOF
systemctl daemon-reload
systemctl restart nginx

# 开启bbr加速 (ubuntu18.04)
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control

# 检测BBR是否开启
lsmod | grep bbr
echo "=========================================xray部署完成!"
