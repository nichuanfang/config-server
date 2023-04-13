#!/bin/bash
cd /cloudnas/CloudDrive/ali-open/backup/mysql/
cp www.vencenter.cn.tar.gz /root/mysql/backup/
cd /root/mysql/backup/
tar -zxvf www.vencenter.cn.tar.gz
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql/backup/music_info.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql/backup/koel.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql/backup/jpress.sql
rm -f www.vencenter.cn.tar.gz
rm -f /root/mysql/backup/*.sql
