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

    # 如果报错需要粘贴这一段 

    # -------------------------start---------------------
    # map $http_upgrade $connection_upgrade {
    #     default upgrade;
    #     ""      close;
    # }

    # map $proxy_protocol_addr $proxy_forwarded_elem {
    #     ~^[0-9.]+$        "for=$proxy_protocol_addr";
    #     ~^[0-9A-Fa-f:.]+$ "for=\"[$proxy_protocol_addr]\"";
    #     default           "for=unknown";
    # }

    # map $http_forwarded $proxy_add_forwarded {
    #     "~^(,[ \\t]*)*([!#$%&'*+.^_`|~0-9A-Za-z-]+=([!#$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?(;([!#$%&'*+.^_`|~0-9A-Za-z-]+=([!#$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?)*([ \\t]*,([ \\t]*([!#$%&'*+.^_`|~0-9A-Za-z-]+=([!#$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?(;([!#$%&'*+.^_`|~0-9A-Za-z-]+=([!#$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?)*)?)*$" "$http_forwarded, $proxy_forwarded_elem";
    #     default "$proxy_forwarded_elem";
    # }
    #----------------------------end-----------------------
   
    map \$http_upgrade \$connection_upgrade {
        default upgrade;
        ""      close;
    }

    map \$proxy_protocol_addr \$proxy_forwarded_elem {
        ~^[0-9.]+$        "for=\$proxy_protocol_addr";
        ~^[0-9A-Fa-f:.]+$ "for=\"[\$proxy_protocol_addr]\"";
        default           "for=unknown";
    }

    map \$http_forwarded \$proxy_add_forwarded {
        "~^(,[ \\t]*)*([!#\$%&'*+.^_`|~0-9A-Za-z-]+=([!#\$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?(;([!#\$%&'*+.^_`|~0-9A-Za-z-]+=([!#\$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?)*([ \\t]*,([ \\t]*([!#\$%&'*+.^_`|~0-9A-Za-z-]+=([!#\$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?(;([!#\$%&'*+.^_`|~0-9A-Za-z-]+=([!#\$%&'*+.^_`|~0-9A-Za-z-]+|\"([\\t \\x21\\x23-\\x5B\\x5D-\\x7E\\x80-\\xFF]|\\\\[\\t \\x21-\\x7E\\x80-\\xFF])*\"))?)*)?)*\$" "\$http_forwarded, \$proxy_forwarded_elem";
        default "\$proxy_forwarded_elem";
    }

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
			resolver 1.1.1.1 valid=365d;
			set \$example https://password.$1;
			proxy_pass \$example;
			proxy_ssl_server_name on;
			
		}
	}
	
	# xray自己偷自己
	# server {
	# 	listen 5555 proxy_protocol ssl http2 proxy_protocol;
 #        server_name      xtls.$1;
		
	# 	# SSL Settings
	# 	##
	# 	#ssl on;
	# 	# 注意文件位置，是从/etc/nginx/下开始算起的
	# 	#ssl证书的pem文件路径
	# 	ssl_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
	# 	#ssl证书的key文件路径
	# 	ssl_certificate_key /root/code/docker/dockerfile_work/xray/cert/key.pem;

	# 	add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
	# 	ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
	# 	ssl_protocols TLSv1.2 TLSv1.3;
	# 	ssl_stapling on;
	# 	ssl_stapling_verify on;
	# 	ssl_trusted_certificate /root/code/docker/dockerfile_work/xray/cert/cert.pem;
	# 	ssl_prefer_server_ciphers on;
	# 	ssl_session_cache shared:SSL:10m;

 #        ssl_session_tickets   on;
	# 	resolver 1.1.1.1 valid=365d;

	# 	ssl_verify_depth 10;
	# 	ssl_session_timeout     1h;
	# 	ssl_early_data          on;

	# 	location / {
 #            sub_filter                            $proxy_host $host;
 #            sub_filter_once                       off;

 #            set $website                          password.$1;
 #            proxy_pass                            https://$website;

 #            proxy_set_header Host                 $proxy_host;

 #            proxy_http_version                    1.1;
 #            proxy_cache_bypass                    $http_upgrade;

 #            proxy_ssl_server_name                 on;

 #            proxy_set_header Upgrade              $http_upgrade;
 #            proxy_set_header Connection           $connection_upgrade;
 #            proxy_set_header X-Real-IP            $proxy_protocol_addr;
 #            proxy_set_header Forwarded            $proxy_add_forwarded;
 #            proxy_set_header X-Forwarded-For      $proxy_add_x_forwarded_for;
 #            proxy_set_header X-Forwarded-Proto    $scheme;
 #            proxy_set_header X-Forwarded-Host     $host;
 #            proxy_set_header X-Forwarded-Port     $server_port;

 #            proxy_connect_timeout                 60s;
 #            proxy_send_timeout                    60s;
 #            proxy_read_timeout                    60s;

 #            proxy_set_header Early-Data           $ssl_early_data;
 #        }
	# }

	# xray配置服务器
	server {
		listen 443  ssl http2;
		
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
		ssl_session_tickets   on;
		resolver 1.1.1.1 valid=365d;
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
		listen 443  ssl http2;
		
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

        ssl_session_tickets   on;
		resolver 1.1.1.1 valid=365d;
        
		ssl_verify_depth 10;
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
			proxy_set_header Host \$host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
		}

		location /notifications/hub/negotiate {
			proxy_pass http://127.0.0.1:7006;
			proxy_set_header Host \$host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
		}
	}

	# bark server
	server {
		listen 443  ssl http2;
		
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
		ssl_session_tickets   on;
		resolver 1.1.1.1 valid=365d;
        ssl_session_timeout     1h;
        ssl_early_data          on;


		# 这里配置拒绝访问的目录或文件
		# location ~ (repos) 
		# {
		#     deny all;
		# }

		# bark服务
		location / {
			proxy_pass http://127.0.0.1:8080/;
			proxy_set_header Host \$host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
		}
	}

	# telegram bot webhook
  server {
  		listen 443  ssl http2;
  		server_name bot.$1;

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

      ssl_session_tickets   on;
  		resolver 1.1.1.1 valid=365d;

  		ssl_verify_depth 10;
      ssl_session_timeout     1h;
      ssl_early_data          on;


  		location /webhook/dogyun {
  			proxy_pass http://127.0.0.1:10000/webhook/dogyun;
  			proxy_set_header Host \$host;
  			proxy_set_header X-Real-IP \$remote_addr;
  			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  			proxy_set_header X-Forwarded-Proto \$scheme;
  		}

  		location /webhook/github_workflow {
  			proxy_pass http://127.0.0.1:10001/webhook/github_workflow;
  			proxy_set_header Host \$host;
  			proxy_set_header X-Real-IP \$remote_addr;
  			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  			proxy_set_header X-Forwarded-Proto \$scheme;
  		}

  		location /webhook/tmdb {
  			proxy_pass http://127.0.0.1:10002/webhook/tmdb;
  			proxy_set_header Host \$host;
  			proxy_set_header X-Real-IP \$remote_addr;
  			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  			proxy_set_header X-Forwarded-Proto \$scheme;
  		}

  		location /webhook/gpt {
  			proxy_pass http://127.0.0.1:10003/webhook/gpt;
  			proxy_set_header Host \$host;
  			proxy_set_header X-Real-IP \$remote_addr;
  			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  			proxy_set_header X-Forwarded-Proto \$scheme;
  		}

  		location /webhook/watermark_remove {
        			proxy_pass http://127.0.0.1:10004/webhook/watermark_remove;
        			proxy_set_header Host \$host;
        			proxy_set_header X-Real-IP \$remote_addr;
        			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        			proxy_set_header X-Forwarded-Proto \$scheme;
        		}
  }

  # portainer监控
  server {
  		listen 443  ssl http2;

  		server_name monitor.$1;

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
  		ssl_session_tickets   on;
  		resolver 1.1.1.1 valid=365d;
          ssl_session_timeout     1h;
          ssl_early_data          on;


  		location / {
  			proxy_pass http://127.0.0.1:9000/;
  			proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
  		}
  }
 
 	server {
		listen 80;
		server_name $1 *.$1;
		if ( \$host = "$1" ) {
			rewrite ^/(.*)$ http://www.$1\$1 permanent;
			return 200;
		}
		rewrite ^(.*)$ https://\$host\$1 permanent;
	}
}
EOF
systemctl daemon-reload
systemctl restart nginx

echo "=========================================nginx部署完成!"
