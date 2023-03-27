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
