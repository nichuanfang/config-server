#!/bin/bash

# 配置ubuntu20的时区

# 更新软件源
apt-get update -y
# 通过expect模拟用户交互
apt install expect -y

echo "====================================================开始同步时间..."

echo "同步前的时间: $(date -R)"

# (1) 时间同步服务端容器(可选也可以用外部ntp服务器)

apt install -y chrony
cat /dev/null >/etc/chrony/chrony.conf
sudo tee -a /etc/chrony/chrony.conf <<'EOF'
pool ntp.aliyun.com iburst maxsources 4
keyfile /etc/chrony/chrony.keys
driftfile /var/lib/chrony/chrony.drift
logdir /var/log/chrony
maxupdateskew 100.0
rtcsync
# 允许跳跃式校时 如果在前 3 次校时中时间差大于 1.0s
makestep 1 3
EOF

systemctl enable chrony && systemctl restart chrony && systemctl status chrony -l

# (2) 时区与地区设置:

sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai
# sudo dpkg-reconfigure tzdata  # 修改确认
# sudo bash -c "echo 'Asia/Shanghai' > /etc/timezone" # 与上一条命令一样
# 将当前的 UTC 时间写入硬件时钟 (硬件时间默认为UTC)
sudo timedatectl set-local-rtc 0
# 启用NTP时间同步：
sudo timedatectl set-ntp yes
# 校准时间服务器-时间同步(推荐使用chronyc进行平滑同步)
sudo chronyc tracking
# 手动校准-强制更新时间
# chronyc -a makestep
# 系统时钟同步硬件时钟
# sudo hwclock --systohc
sudo hwclock -w

# (3) 重启依赖于系统时间的服务
sudo systemctl restart rsyslog.service cron.service
timedatectl

echo "同步后的时间: $(date -R)"

echo "=====================================================================时间同步完成!"

# 之后端口 环境变量 防火墙 接着等待重启 配置定时任务,python,node(npm),docker,部署应用等...
