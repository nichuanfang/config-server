#!/bin/bash

# 更新docker项目
bash ~/hook.sh

rm -rf /root/docker/dockerfile_work/xray/cert/*.pem

/root/.acme.sh/acme.sh --issue \
		-d "$0" \
		--server letsencrypt \
		--keylength ec-256 \
		--fullchain-file /root/docker/dockerfile_work/xray/cert \
		--key-file /root/docker/dockerfile_work/xray/cert \
		--standalone \
		--force 
    
echo "Xray Certificates Renewed"

chmod 777 /root/docker/dockerfile_work/xray/cert/*.pem

echo "Read Permission Granted for Private Key"

# 用户名
git config --global user.name "$1"
# 邮箱
git config --global user.email "$2"

# 提交git

# 添加到本地库
git add /root/docker/dockerfile_work/xray/cert/*.pem
# 提交信息
git commit /root/docker/dockerfile_work/xray/cert/*.pem -m '🐳 chore: 证书已更新'
# 推送
git push

docker restart xray

echo "Xray Restarted"
