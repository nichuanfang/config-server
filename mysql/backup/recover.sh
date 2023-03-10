#!/bin/bash
cp /cloudnas/CloudDrive/ali-open/backup/mysql/www.vencenter.cn.tar.gz /root/mysql_backup/
cd /root/mysql_backup/
tar -zxvf www.vencenter.cn.tar.gz
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/music_info.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/koel.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/jpress.sql
rm -f www.vencenter.cn.tar.gz
