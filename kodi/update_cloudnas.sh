#!/bin/bash


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
docker rm -f clouddrive2
docker rmi -f cloudnas/clouddrive2:latest
docker pull docker.m.daocloud.io/cloudnas/clouddrive2:latest
docker tag docker.m.daocloud.io/cloudnas/clouddrive2:latest cloudnas/clouddrive2:latest
docker rmi -f docker.m.daocloud.io/cloudnas/clouddrive2:latest
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
     cloudnas/clouddrive2:latest

echo "clouddrive2启动完成!"

exit 0



