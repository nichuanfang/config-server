#!/bin/bash
# 备份指定数据库

#音乐信息表
docker exec mysql sh -c 'exec mysqldump --databases music_info -u root -p'${1} >/root/mysql_backup/music_info.sql
#koel表
docker exec mysql sh -c 'exec mysqldump --databases koel -u root -p'${1} >/root/mysql_backup/koel.sql
#个人博客数据
docker exec mysql sh -c 'exec mysqldump --databases jpress -u root -p'${1} >/root/mysql_backup/jpress.sql
# 保存到阿里云
cd /root/mysql_backup
find . -name "*.sql" | xargs tar czvf www.vencenter.cn.tar.gz
cp /root/mysql_backup/www.vencenter.cn.tar.gz /cloudnas/CloudDrive/ali-open/backup/mysql/
rm -f /root/mysql_backup/www.vencenter.cn.tar.gz
