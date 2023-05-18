#!/bin/bash
echo "==========================================开始设置启动脚本..."

sudo cat /dev/null >/lib/systemd/system/rc.local.service

# /etc/rc.local文件的启动顺序是在网络后面，但是显然它少了[Install]段，也就没有定义如何做到开机启动，所以这样配置是无效的。因此我们就需要在后面帮他加上[Install]段：
sudo cat <<EOF >/lib/systemd/system/rc.local.service
#  SPDX-License-Identifier: LGPL-2.1+
#
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

# This unit gets pulled automatically into multi-user.target by
# systemd-rc-local-generator if /etc/rc.local is executable.
[Unit]
Description=/etc/rc.local Compatibility
Documentation=man:systemd-rc-local-generator(8)
ConditionFileIsExecutable=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes
GuessMainPID=no

[Install]  
WantedBy=multi-user.target 

Alias=rc-local.service
EOF

# 注意 ：脚本或者开机执行的命令要在exit0之前。
sudo cat /dev/null >/etc/rc.local
sudo cat <<EOF >/etc/rc.local
#!/bin/bash
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# ---------------------------你的脚本---------------------------------
cd /root/code/docker/docker-compose
docker-compose up -d
# ---------------------------你的脚本---------------------------------
exit 0
EOF

systemctl daemon-reload
systemctl enable rc-local.service
echo "==========================================启动脚本设置成功!"
