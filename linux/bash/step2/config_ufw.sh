#!/bin/bash

# 配置ubuntu18的防火墙

SSHPORT=60022
echo "[-] 系统防火墙启用以及规则设置 "
systemctl enable ufw.service && systemctl start ufw.service && ufw enable
# sudo ufw allow proto tcp to any port 60022
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8080
# sudo ufw allow 22
sudo ufw allow ${SSHPORT}

# 重启修改配置相关服务
systemctl restart sshd
