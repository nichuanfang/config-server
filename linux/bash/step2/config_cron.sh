#!/bin/bash

# 配置ubuntu18的定时任务

echo "==========================================开始配置定时任务..."

sudo cat <<EOF >/etc/crontab
# min hour day-month month day-week

#每天定时清理缓存
0 4 * * * sync && echo 3 > /proc/sys/vm/drop_caches
# 每月1号更新证书
0 13 1 * * /bin/bash <(curl -L https://raw.githubusercontent.com/nichuanfang/config-server/master/linux/bash/step2/renew_cert.sh) $1
EOF
echo "==========================================定时任务配置完成!"
