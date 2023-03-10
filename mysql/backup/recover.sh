#!/bin/bash
# 从阿里云拉取数据
cp -r -n /cloudnas/data/CloudDrive/ali-open/backup/mysql/music_info.sql /root/mysql_backup/
# 恢复
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/music_info.sql
