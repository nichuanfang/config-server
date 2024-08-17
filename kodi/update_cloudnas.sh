#!/bin/bash

#github代理
GITHUB_PROXY=$1
# dockerhub代理
DOCKER_HUB_PROXY=$2
#检测是否需要更新

latest_version=$(curl -s "https://$GITHUB_PROXY/https://hub.docker.com/v2/repositories/cloudnas/clouddrive2/tags/" | python3 -c "import sys, json; print(json.load(sys.stdin)['results'][1]['name'])")

echo "cloudnas最新版本: $latest_version"

#获取当前版本
current_version=$(docker images | grep cloudnas/clouddrive2 | awk '{print $2}')
echo "当前版本: $current_version"

if [ -n "$current_version" ] && [ "$latest_version" == "$current_version" ]; then
echo  "无需更新cloudnas"
exit 0
fi

# clouddrive2 install script for CoreELEC
echo "开始更新clouddrive2...."

#enable shared mount option for mapped volume in host
mount --make-shared /storage

#创建相应目录赋予权限     [   ]  内  前后都要有空格 if与[ ]之间也要有空格
if [ ! -d "/storage/cloudnas" ]; then
mkdir -p /storage/cloudnas
chmod 777 /storage/cloudnas
fi

if [ ! -d "/storage/clouddrive2/config" ]; then
mkdir -p /storage/clouddrive2/config
chmod 777 /storage/clouddrive2/config
fi

#更新clouddrive2
echo "开始更新clouddrive2镜像..."
if [ -n "$current_version" ]; then
docker rm -f clouddrive2
docker rmi -f cloudnas/clouddrive2:"$current_version"
fi
docker pull $DOCKER_HUB_PROXY/cloudnas/clouddrive2:"$latest_version"
docker tag $DOCKER_HUB_PROXY/cloudnas/clouddrive2:"$latest_version" cloudnas/clouddrive2:"$latest_version"
docker rmi -f $DOCKER_HUB_PROXY/cloudnas/clouddrive2:"$latest_version"
echo "clouddrive2镜像更新完毕!"

# 删除原挂载目录
if [ -d  "/storage/cloudnas/CloudDrive" ]; then
#  卸载挂载目录
umount /storage/cloudnas/CloudDrive
rm -rf /storage/cloudnas/CloudDrive
fi

echo "Clouddrive2更新完毕!"
#启动容器
echo "开始启动clouddrive2...."
docker run -d \
      --name clouddrive2 \
      --restart always \
      --env CLOUDDRIVE_HOME=/Config \
      --env UID=0 \
      --env GID=0 \
      -v /storage/cloudnas:/CloudNAS:shared \
      -v /storage/clouddrive2/config:/Config \
      --network host \
      --pid host \
     --privileged \
     --device /dev/fuse:/dev/fuse \
     cloudnas/clouddrive2:"$latest_version"

echo "clouddrive2启动完成!"

exit 0
