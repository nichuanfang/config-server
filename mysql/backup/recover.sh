#!/bin/bash
#cp -r /cloudnas/data/CloudDrive/ali-open/backup/mysql/music_info.sql /root/mysql_backup/
#cp -r /cloudnas/data/CloudDrive/ali-open/backup/mysql/koel.sql /root/mysql_backup/
#cp -r /cloudnas/data/CloudDrive/ali-open/backup/mysql/jpress.sql /root/mysql_backup/

docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/music_info.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/koel.sql
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/jpress.sql
