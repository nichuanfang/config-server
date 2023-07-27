#!/bin/bash

# 部署ubuntu18的应用
echo "==========================================开始配置git..."

sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend

mkdir -p /root/code && cd /root/code
sudo apt-get install git -y

# 写入git全局配置
sudo cat <<EOF >~/.gitconfig
[credential]
	helper = store
[user]
	email = $1@gmail.com
	name = jaychouzzz
EOF

# 写入git凭据  @用%40代替
sudo cat <<EOF >~/.git-credentials
https://$1%40gmail.com:$2@github.com
EOF

# 拉取项目
git clone https://github.com/nichuanfang/config-server.git
git clone https://github.com/nichuanfang/xray-parser.git
git clone https://github.com/nichuanfang/hexo-blog.git
git clone https://github.com/nichuanfang/docker.git
git clone https://github.com/nichuanfang/crawler.git
git clone https://github.com/nichuanfang/nginx-config.git
git clone https://github.com/nichuanfang/MyScripts.git
git clone https://github.com/nichuanfang/certbot.git
git clone https://github.com/nichuanfang/bitwarden-backup.git

echo "==========================================git配置完成!"
