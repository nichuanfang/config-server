#!/bin/bash

# 配置ubuntu18的防火墙
echo "==========================================================开始系统防火墙启用以及规则设置..."
systemctl enable ufw.service && systemctl start ufw.service && ufw --force enable
sudo ufw allow 60456
sudo ufw allow 21
# sudo ufw allow 22
sudo ufw allow 23
sudo ufw allow 53
sudo ufw allow 443
sudo ufw allow 8443
# ssh端口
sudo ufw allow $1

# 重启修改配置相关服务
systemctl restart sshd

echo "==========================================================系统防火墙启用以及规则设置完成! "
