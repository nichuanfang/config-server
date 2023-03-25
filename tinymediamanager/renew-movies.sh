#!/bin/bash

docker start tinymediamanager
cd /cloudnas/CloudDrive/ali-open/tmm/tmm-movies
# 刮削电影
curl \
    -d '[{"action":"update", "scope":{"name":"all"}},{"action":"scrape", "scope":{"name":"new"}}]' \
    -H "Content-Type: application/json" \
    -H "api-key: $0" \
    -X POST http://localhost:7878/api/movies
sleep 1h
cd /cloudnas/CloudDrive/ali-open/tmm/tmm-movies
mv ./* /cloudnas/CloudDrive/ali-open/movies/
docker stop tinymediamanager
