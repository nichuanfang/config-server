#!/bin/bash

# 配置ubuntu18的docker环境

echo "==========================================开始配置docker环境..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
sudo apt-get install docker.io -y

echo "开始安装docker-compose..."

# 官方git地址下载
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 修改权限
chmod +x /usr/local/bin/docker-compose

echo "docker-compose安装完成!"

# 创建docker配置文件
cat /dev/null >/etc/docker/daemon.json
# 控制docker容器大小
cat <<EOF >/etc/docker/daemon.json
{
  "log-driver":"json-file",
  "log-opts": {"max-size":"80m", "max-file":"1"}
}
EOF
# 重载配置 重启容器
systemctl daemon-reload && systemctl restart docker


echo "==========================================docker环境配置完成!"
