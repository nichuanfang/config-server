#!/bin/bash

# 配置ubuntu18的定时任务(vps专用)

echo "==========================================开始配置定时任务..."

touch /root/cron
cat <<EOF >/root/cron
# 每月1号更新证书
30 13 1 * * /bin/bash <(curl -L https://raw.githubusercontent.com/nichuanfang/config-server/master/linux/bash/step2/vps/renew_cert.sh) $1
#每天定时清理缓存
30 13 1 * * sync && echo 3 >/proc/sys/vm/drop_caches
#每天9点启动应用服务器
0 9 * * * curl --location -g --header "API-KEY: $2" --request PUT 'https://api.dogyun.com/cvm/server/43541/resume'
#每天1点暂停应用服务器
0 1 * * * curl --location -g --header "API-KEY: $2" --request PUT 'https://api.dogyun.com/cvm/server/43541/suspend'
# 每天定时更新github壁纸
0 0 * * * /bin/bash <(curl -L https://raw.githubusercontent.com/nichuanfang/nichuanfang/main/cron/update_wallpaper.sh) nichuanfang nichuanfang $3
EOF

# 载入crontab
crontab /root/cron
# 删除临时文件
rm -f /root/cron

echo "==========================================定时任务配置完成!"
