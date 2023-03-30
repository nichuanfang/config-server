# !/bin/bash
wget 服务器配置地址 -O /usr/local/etc/xray/config.json
systemctl restart xray
