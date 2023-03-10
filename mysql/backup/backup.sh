#!/bin/bash
# 备份指定数据库

#音乐信息表
docker exec mysql sh -c 'exec mysqldump --databases music_info -u root -p'${1} >/root/mysql_backup/music_info.sql
#koel表
docker exec mysql sh -c 'exec mysqldump --databases koel -u root -p'${1} >/root/mysql_backup/koel.sql
#个人博客数据
docker exec mysql sh -c 'exec mysqldump --databases jpress -u root -p'${1} >/root/mysql_backup/jpress.sql
# 保存到阿里云
#cp -r /root/mysql_backup/music_info.sql /cloudnas/data/CloudDrive/ali-open/backup/mysql/
#cp -r /root/mysql_backup/koel.sql /cloudnas/data/CloudDrive/ali-open/backup/mysql/
#cp -r /root/mysql_backup/jpress.sql /cloudnas/data/CloudDrive/ali-open/backup/mysql/
