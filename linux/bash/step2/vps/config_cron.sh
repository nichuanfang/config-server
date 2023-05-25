#!/bin/bash

# 配置ubuntu18的定时任务(vps专用)

echo "==========================================开始配置定时任务..."

# 开启cron日志 修改rsyslog:
cat /dev/null >/etc/rsyslog.d/50-default.conf
cat <<EOF >/etc/rsyslog.d/50-default.conf
#  Default rules for rsyslog.
#
#                       For more information see rsyslog.conf(5) and /etc/rsyslog.conf

#
# First some standard log files.  Log by facility.
#
auth,authpriv.*                 /var/log/auth.log
*.*;auth,authpriv.none          -/var/log/syslog
cron.*                          /var/log/cron.log
#daemon.*                       -/var/log/daemon.log
kern.*                          -/var/log/kern.log
#lpr.*                          -/var/log/lpr.log
mail.*                          -/var/log/mail.log
#user.*                         -/var/log/user.log

#
# Logging for the mail system.  Split it up so that
# it is easy to write scripts to parse these files.
#
#mail.info                      -/var/log/mail.info
#mail.warn                      -/var/log/mail.warn
mail.err                        /var/log/mail.err

#
# Some "catch-all" log files.
#
#*.=debug;\
#       auth,authpriv.none;\
#       news.none;mail.none     -/var/log/debug
#*.=info;*.=notice;*.=warn;\
#       auth,authpriv.none;\
#       cron,daemon.none;\
#       mail,news.none          -/var/log/messages

#
# Emergencies are sent to everybody logged in.
#
*.emerg                         :omusrmsg:*

#
# I like to have messages displayed on the console, but only on a virtual
# console I usually leave idle.
#
#daemon,mail.*;\
#       news.=crit;news.=err;news.=notice;\
#       *.=debug;*.=info;\
#       *.=notice;*.=warn       /dev/tty8
EOF

# 重启rsyslog & cron
sudo service rsyslog restart
sudo service cron restart

touch /root/cron
cat <<EOF >/root/cron
# 每月1号更新证书
30 13 1 * * /bin/bash <(curl -L https://raw.githubusercontent.com/nichuanfang/config-server/master/linux/bash/step2/vps/renew_cert.sh) $1
#每天定时清理缓存
30 13 1 * * sync && echo 3 >/proc/sys/vm/drop_caches
# 定期删除cron日志
30 13 1 * * cat /dev/null > /var/log/cron.log
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
