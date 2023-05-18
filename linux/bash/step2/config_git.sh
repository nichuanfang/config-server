#!/bin/bash

# 部署ubuntu18的应用
echo "==========================================开始配置git..."

mkdir -p /root/code && cd /root/code

sudo apt-get install git -y

# 写入git全局配置
sudo cat <<'EOF' >~/.gitconfig
[credential]
	helper = store
[user]
	email = $1@gmail.com
	name = jaychouzzz
EOF

# 写入git凭据  @用%40代替
sudo cat <<'EOF' >~/.git-credentials
https://$1%40gmail.com:$2@github.com
EOF

echo "==========================================git配置完成!"
