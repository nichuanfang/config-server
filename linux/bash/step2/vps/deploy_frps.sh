# 部署frps

# 创建frps文件夹
mkdir -p ~/data/frp

# 下载frps和配置文件(自行准备)

# 创建 frps.service 文件
cat <<EOF > /etc/systemd/system/frps.service
[Unit]
Description = frp server
After = network.target syslog.target
Wants = network.target
[Service]
Type = simple
ExecStart = /root/data/frp/frps -c /root/data/frp/frps.toml
[Install]
WantedBy = multi-user.target
EOF

# 开机启动
sudo systemctl enable frps

# 启动frp
sudo systemctl start frps
