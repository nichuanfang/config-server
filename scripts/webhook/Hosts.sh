#!/bin/bash

# 定时更新hosts文件
if [ ! -d '/root/assets/hosts/Hosts' ]; then
    cd /root/assets/hosts
    git clone https://github.com/nichuanfang/Hosts.git
    docker restart nginx
    exit 0
fi
cd /root/assets/hosts/Hosts
git pull
docker restart nginx
exit 0
