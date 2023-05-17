#!/bin/bash

SSHPORT=$1
# SSHPORT=60022

echo "==================================================开始安全配置..."
echo "[-] 设置或恢复重要目录和文件的权限"
chmod 755 /etc
chmod 777 /tmp
chmod 700 /etc/inetd.conf 2 &>/dev/null &>/dev/null
chmod 755 /etc/passwd
chmod 755 /etc/shadow
chmod 644 /etc/group
chmod 755 /etc/security
chmod 644 /etc/services
chmod 750 /etc/rc*.d
chmod 600 ~/.ssh/authorized_keys

echo "[-] 删除潜在威胁文件 "
find / -maxdepth 3 -name hosts.equiv | xargs rm -rf
find / -maxdepth 3 -name .netrc | xargs rm -rf
find / -maxdepth 3 -name .rhosts | xargs rm -rf

# 严格模式
sudo egrep -q "^\s*StrictModes\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*StrictModes\s+.+$/StrictModes yes/" /etc/ssh/sshd_config || echo "StrictModes yes" >>/etc/ssh/sshd_config
if [ -e ${SSHPORT} ]; then export SSHPORT=${SSHPORT}; fi
sudo egrep -q "^\s*Port\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*Port\s+.+$/Port ${SSHPORT}/" /etc/ssh/sshd_config || echo "Port ${SSHPORT}" >>/etc/ssh/sshd_config
# 禁用X11转发以及端口转发
sudo egrep -q "^\s*X11Forwarding\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*X11Forwarding\s+.+$/X11Forwarding no/" /etc/ssh/sshd_config || echo "X11Forwarding no" >>/etc/ssh/sshd_config
sudo egrep -q "^\s*X11UseLocalhost\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*X11UseLocalhost\s+.+$/X11UseLocalhost yes/" /etc/ssh/sshd_config || echo "X11UseLocalhost yes" >>/etc/ssh/sshd_config
sudo egrep -q "^\s*AllowTcpForwarding\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*AllowTcpForwarding\s+.+$/AllowTcpForwarding no/" /etc/ssh/sshd_config || echo "AllowTcpForwarding no" >>/etc/ssh/sshd_config
sudo egrep -q "^\s*AllowAgentForwarding\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*AllowAgentForwarding\s+.+$/AllowAgentForwarding no/" /etc/ssh/sshd_config || echo "AllowAgentForwarding no" >>/etc/ssh/sshd_config
# 关闭禁用用户的 .rhosts 文件  ~/.ssh/.rhosts 来做为认证: 缺省IgnoreRhosts yes
egrep -q "^(#)?\s*IgnoreRhosts\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^(#)?\s*IgnoreRhosts\s+.+$/IgnoreRhosts yes/" /etc/ssh/sshd_config || echo "IgnoreRhosts yes" >>/etc/ssh/sshd_config
# 禁止root远程登录（推荐配置-根据需求配置）
# egrep -q "^\s*PermitRootLogin\s+.+$" /etc/ssh/sshd_config && sed -ri "s/^\s*PermitRootLogin\s+.+$/PermitRootLogin no/" /etc/ssh/sshd_config || echo "PermitRootLogin no" >>/etc/ssh/sshd_config

# 登陆前后欢迎提示设置
egrep -q "^\s*(banner|Banner)\s+\W+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*(banner|Banner)\s+\W+.*$/Banner \/etc\/issue/" /etc/ssh/sshd_config ||
    echo "Banner /etc/issue" >>/etc/ssh/sshd_config
echo "[-] 远程SSH登录前后提示警告Banner设置"
# SSH登录前警告Banner
sudo tee /etc/issue <<'EOF'
****************** [ 安全登陆 (Security Login) ] *****************
Authorized only. All activity will be monitored and reported.By Security Center.
Author: Nichuanfang, Site: https://www.vencenter.cn

EOF
# SSH登录后提示Banner
sed -i '/^fi/a\\n\necho "\\e[1;37;41;5m################## 安全运维 (Security Operation) ####################\\e[0m"\necho "\\e[32mLogin success. Please execute the commands and operation data carefully.By Nichuanfang.\\e[0m"' /etc/update-motd.d/00-header

# 用户远程登录失败次数与终端超时设置
echo "[-] 用户远程连续登录失败10次锁定帐号5分钟包括root账号"
sed -ri "/^\s*auth\s+required\s+pam_tally2.so\s+.+(\s*#.*)?\s*$/d" /etc/pam.d/sshd
sed -ri '2a auth required pam_tally2.so deny=10 unlock_time=300 even_deny_root root_unlock_time=300' /etc/pam.d/sshd
# 宿主机控制台登陆(可选)
# sed -ri "/^\s*auth\s+required\s+pam_tally2.so\s+.+(\s*#.*)?\s*$/d" /etc/pam.d/login
# sed -ri '2a auth required pam_tally2.so deny=5 unlock_time=300 even_deny_root root_unlock_time=300' /etc/pam.d/login

echo "[-] 设置登录超时时间为10分钟 "
egrep -q "^\s*(export|)\s*TMOUT\S\w+.*$" /etc/profile && sed -ri "s/^\s*(export|)\s*TMOUT.\S\w+.*$/export TMOUT=600\nreadonly TMOUT/" /etc/profile || echo -e "export TMOUT=600\nreadonly TMOUT" >>/etc/profile
egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 600/" /etc/ssh/sshd_config || echo "ClientAliveInterval 600" >>/etc/ssh/sshd_config

# 用户终端执行的历史命令记录
echo "[-] 用户终端执行的历史命令记录 "
egrep -q "^HISTSIZE\W\w+.*$" /etc/profile && sed -ri "s/^HISTSIZE\W\w+.*$/HISTSIZE=101/" /etc/profile || echo "HISTSIZE=101" >>/etc/profile
# 方式1
sudo tee /etc/profile.d/history-record.sh <<'EOF'
# 历史命令执行记录文件路径
mkdir -p /var/log/.history/
LOGTIME=$(date +%Y%m%d-%H-%M-%S)
export HISTFILE="/var/log/.history/${USER}.${LOGTIME}.history"
if [ ! -f ${HISTFILE} ];then
  touch ${HISTFILE}
fi
chmod 600 /var/log/.history/${USER}.${LOGTIME}.history
# 历史命令执行文件大小记录设置
HISTFILESIZE=128
HISTTIMEFORMAT="%F_%T $(whoami)#$(who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'):"
EOF
echo "==================================================安全配置完成!"
