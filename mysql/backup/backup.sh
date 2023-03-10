#!/bin/bash
# 备份指定数据库
docker exec mysql sh -c 'exec mysqldump --databases music_info -u root -p'${1} >/root/mysql_backup/music_info.sql
# 保存到阿里云
cp -r -n /root/mysql_backup/music_info.sql /cloudnas/data/CloudDrive/ali-open/backup/mysql/
