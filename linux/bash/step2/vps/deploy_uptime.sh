# 准备uptime数据目录
mkdir -p ~/data/uptime_kuma

# 恢复数据...(自行恢复)

# 部署
cd /root/code/docker/dockerfile_work/uptime_kuma
docker-compose up -d
