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
	# SSL Settings
	##
	# 注意文件位置，是从/etc/nginx/下开始算起的
	# ssl_certificate cert/cert.pem;
    # ssl_certificate_key cert/key.pem;
    # ssl_session_timeout 5m;
    # ssl_protocols TLSv1 TLSv1.1 TLSv1.2;   
    # ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    # ssl_prefer_server_ciphers on;
    # client_max_body_size 1024m; 

	# ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	# ssl_prefer_server_ciphers on;

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
        listen 80;
        server_name  $1 *$1;
		root /root/code/docker/dockerfile_work/xray/config;

		autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        auth_basic "authentication";
        auth_basic_user_file /etc/nginx/passwdfile;
        charset utf-8;
        
        # 这里配置拒绝访问的目录或文件
        # location ~ (repos) 
        # {
        #     deny all;
        # }

        # 静态文件的过期时间，可以不需要此配置
        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
		{
			expires      30d;
		}
                
        # 静态文件的过期时间，可以不需要此配置
        location ~ .*\.(js|css)?$
		{
			expires      12h;
		}
    	# 这里很重要! 将日志转发到 /dev/stdout ，可以通过 docker logs -f  来查看容器日志
        # access_log  /dev/stdout;
        
    }
}
EOF
systemctl daemon-reload
systemctl restart nginx
echo "=========================================xray部署完成!"
