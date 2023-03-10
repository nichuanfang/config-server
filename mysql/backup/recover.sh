#!/bin/bash
# 恢复数据库
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/music_info.sql
