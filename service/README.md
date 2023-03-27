# linux服务

* 服务定义格式

```
[Unit]
Description=Process Monitoring and Control Daemon 
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

* 常用服务

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
