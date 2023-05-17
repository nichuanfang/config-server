#!/bin/bash

# 配置ubuntu18的定时任务

echo "==========================================开始配置定时任务..."

sudo cat <<'EOF' >/etc/crontab
# min hour day-month month day-week

#每天定时清理缓存
0 4 * * * sync && echo 3 > /proc/sys/vm/drop_caches


EOF

echo "==========================================定时任务配置完成!"
