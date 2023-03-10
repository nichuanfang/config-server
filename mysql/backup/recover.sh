#!/bin/bash
cp -r /cloudnas/data/CloudDrive/ali-open/backup/mysql/*.sql /root/mysql_backup/
docker exec -i mysql sh -c 'exec mysql -uroot -p'${1}  < /root/mysql_backup/*.sql
