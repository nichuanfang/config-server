#!/bin/bash
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
yum install docker-ce
systemctl start docker
systemctl enable docker
groupadd docker
usermod -aG docker $USER
echo "docker安装完成!"
curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
echo "docker-compose安装完成"
