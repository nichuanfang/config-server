#!/bin/bash

echo "开始创建clouddrive2..."

#enable shared mount option for mapped volume in host
mount --make-shared /storage

#创建相应目录赋予权限
if [ ! -d "/storage/cloudnas"]; then
mkdir -p /storage/cloudnas
chmod 777 /storage/cloudnas
fi

if [ ! -d "/storage/clouddrive2/config"]; then
mkdir -p /storage/clouddrive2/config
chmod 777 /storage/clouddrive2/config
fi

#更新clouddrive2

docker rm -f clouddrive

docker rmi -f cloudnas/clouddrive2-unstable:latest

#拉取代理镜像并重命名
docker pull dockerproxy.com/cloudnas/clouddrive2-unstable:latest
docker tag dockerproxy.com/cloudnas/clouddrive2-unstable:latest cloudnas/clouddrive2-unstable:latest
docker rmi dockerproxy.com/cloudnas/clouddrive2-unstable:latest

#启动容器
/bin/bash -c "$(curl -L https://ghproxy.com/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cloudnas_init.sh)"

echo "clouddrive2启动完成!"

exit 0
