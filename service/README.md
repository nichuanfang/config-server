# linux服务

## 服务定义格式

```
[Unit]:服务的说明
Description:描述服务
After:描述服务类别

[Service]服务运行参数的设置
Type=forking            是后台运行的形式
ExecStart               为服务的具体运行命令
ExecReload              为服务的重启命令
ExecStop                为服务的停止命令
PrivateTmp=True         表示给服务分配独立的临时空间
注意：启动、重启、停止命令全部要求使用绝对路径

[Install]               服务安装的相关设置，可设置为多用户
WantedBy=multi-user.target 
```
## 常用指令
1. 设置开机自启动   `systemctl enable xxx.service`
2. 停止开机自启动   `systemctl disable xxx.service`
3. 验证一下是否为开机启动  `systemctl is-enabled xxx.service`
4. 启动服务  `systemctl start xxx.service`
5. 停止服务  `systemctl stop xxx.service`
6. 重启服务  `systemctl restart xxx.service`
7. 重载配置文件  `systemctl daemon-reload`
8. 查看所有已启动的服务  `systemctl list-units --type=service`

## 常用服务

1. webhook服务
```
[Unit]
Description=Webhook Service
After=rc-local.service nss-user-lookup.target

[Service]
Type=forking
ExecStart=/root/webhook/start
Restart=on-failure
RestartSec=42s
KillMode=process 

[Install]
WantedBy=multi-user.target
```
2. xray服务
```
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
```
