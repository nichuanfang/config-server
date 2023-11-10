#!/bin/bash

# 配置ubuntu18的防火墙
echo "==========================================================开始系统防火墙启用以及规则设置..."
systemctl enable ufw.service && systemctl start ufw.service && ufw --force enable
# sudo ufw allow proto tcp to any port 60022
sudo ufw allow 21
# sudo ufw allow 22
sudo ufw allow 23
sudo ufw allow 53
sudo ufw allow 80
sudo ufw allow 81
sudo ufw allow 88
sudo ufw allow 443
sudo ufw allow 1521
sudo ufw allow 3306
sudo ufw allow 3308
sudo ufw allow 4000
sudo ufw allow 5000
sudo ufw allow 6379
sudo ufw allow 8000
sudo ufw allow 8080
sudo ufw allow 8090
sudo ufw allow 8360
sudo ufw allow 8443
sudo ufw allow 8888
sudo ufw allow 9000
sudo ufw allow 9999
sudo ufw allow 16789
sudo ufw allow 19798
# ssh端口
sudo ufw allow $1

# 重启修改配置相关服务
systemctl restart sshd

echo "==========================================================系统防火墙启用以及规则设置完成! "
