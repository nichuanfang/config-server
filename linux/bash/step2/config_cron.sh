#!/bin/bash

# 配置ubuntu18的定时任务

echo "==========================================开始配置定时任务..."

touch /root/cron
cat <<EOF >/root/cron
# 每月1号更新证书
30 13 1 * * /bin/bash <(curl -L https://raw.githubusercontent.com/nichuanfang/config-server/master/linux/bash/step2/renew_cert.sh) $1
#每天定时清理缓存
30 13 1 * * sync && echo 3 >/proc/sys/vm/drop_caches
# 每月1号数据库备份
# 0 4 1 * * /bin/bash /root/mysql_backup/backup.sh 0820nCf9270
# 每月1号clouddrive2更新
# 0 4 1 * * /bin/bash -c "$(curl -L https://raw.githubusercontent.com/nichuanfang/config-server/master/nas/clouddrive2_install.sh)"
# 每天定时更新vscode壁纸
# 0 4 * * * /bin/bash ~/scripts/switch-vscode-bg.sh
# 每天早上更新m3u源
# 0 4 * * * /bin/bash -c "$(curl -L https://ghproxy.com/https://raw.githubusercontent.com/nichuanfang/config-server/master/m3u8/update.sh)"
EOF

# 载入crontab
crontab /root/cron
# 删除临时文件
# rm -f /root/cron

# 查看定时任务
# crontab -l
echo "==========================================定时任务配置完成!"
