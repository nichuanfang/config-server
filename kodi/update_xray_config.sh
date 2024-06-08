#!/bin/bash

#xray配置文件用户名
USERNAME=$1
#xray配置文件密码
PASSWORD=$2

wget https://"$USERNAME":"$PASSWORD"@www.jaychou.site/client/client-windows-config.json -O /storage/xray/config/config.json

#检测是否需要更新
latest_version=$(curl -s 'https://proxy.jaychou.site/https://hub.docker.com/v2/repositories/teddysun/xray/tags/' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['results'][1]['name'])")

echo "xray最新版本: $latest_version"

#获取当前版本
current_version=$(docker images | grep teddysun/xray | awk '{print $2}')
echo "当前版本: $current_version"

if [ -n "$current_version" ] && [ "$latest_version" == "$current_version" ]; then
echo  "无需更新xray镜像"
#更新配置文件 重启
docker restart xray
exit 0
fi

echo "开始更新xray...."

#创建相应目录赋予权限     [   ]  内  前后都要有空格 if与[ ]之间也要有空格

#日志目录
if [ ! -d "/storage/xray/log" ]; then
mkdir -p /storage/xray/log
chmod 777 /storage/xray/log
fi

#配置文件目录
if [ ! -d "/storage/xray/config" ]; then
mkdir -p /storage/xray/config
chmod 777 /storage/xray/config
fi

#更新xray镜像
echo "开始更新xray镜像..."
if [ -n "$current_version" ]; then
docker rm -f xray
docker rmi -f teddysun/xray:"$current_version"
fi
docker pull docker.m.daocloud.io/teddysun/xray:"$latest_version"
docker tag docker.m.daocloud.io/teddysun/xray:"$latest_version" teddysun/xray:"$latest_version"
docker rmi -f docker.m.daocloud.io/teddysun/xray:"$latest_version"
echo "xray镜像更新完毕!"

#启动容器  socks代理10808 http代理10809
echo "开始启动xray...."

#更新配置文件
docker run -d \
    --name xray \
    --restart always \
    -v /storage/xray/log:/log \
    -v /storage/xray/config:/etc/xray \
    --network host \
    teddysun/xray:"$latest_version"

echo "xray启动完成!"
exit 0



