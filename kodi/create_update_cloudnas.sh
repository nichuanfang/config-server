#!/bin/bash
# clouddrive2 install script for CoreELEC

echo "开始更新clouddrive2...."

#enable shared mount option for mapped volume in host
mount --make-shared /storage

#创建相应目录赋予权限     [   ]  内  前后都要有空格 if与[ ]之间也要有空格
if [ ! -d "/cloudnas" ]; then
mkdir -p /cloudnas
chmod 777 /cloudnas
fi

if [ ! -d "/root/clouddrive2/config" ]; then
mkdir -p /root/clouddrive2/config
chmod 777 /root/clouddrive2/config
fi

#更新clouddrive2

# 删除原clouddrive2容器
docker rm -f clouddrive2

# 删除原clouddrive2容器镜像
docker rmi -f cloudnas/clouddrive2:latest

# 删除原挂载目录
if [ -d  "/cloudnas/CloudDrive" ]; then
rm -rf /cloudnas/CloudDrive
fi

#拉取代理镜像并重命名
docker pull dockerproxy.com/cloudnas/clouddrive2:latest
docker tag dockerproxy.com/cloudnas/clouddrive2:latest cloudnas/clouddrive2:latest
docker rmi dockerproxy.com/cloudnas/clouddrive2:latest

echo "Clouddrive2更新完毕!"
#启动容器
echo "开始启动clouddrive2...."
docker run -d \
      --name clouddrive2 \
      --restart always \
      --env CLOUDDRIVE_HOME=/Config \
      --env UID=0 \
      --env GID=0 \
      -v /cloudnas:/CloudNAS:shared \
      -v /root/clouddrive2/config:/Config \
      --network host \
      --pid host \
     --privileged \
     --device /dev/fuse:/dev/fuse \
     cloudnas/clouddrive2:latest

echo "clouddrive2启动完成!"

exit 0



