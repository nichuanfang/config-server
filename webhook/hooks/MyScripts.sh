# !/bin/bash

# 通过webhook执行此脚本 提供js的https服务

if [ ! -d '/root/assets/js/MyScripts' ]; then
    cd /root/assets/js
    git clone https://github.com/nichuanfang/MyScripts.git
    docker restart nginx
    exit 0
fi
cd /root/assets/js/MyScripts
git pull
docker restart nginx
exit 0
