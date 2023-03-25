# !/bin/bash
docker restart clouddrive2 
sleep 3s
docker start tinymediamanager
sleep 3s
# 刮削剧集
curl \
-d '[{"action":"update", "scope":{"name":"all"}},{"action":"scrape", "scope":{"name":"new"}}]' \
-H "Content-Type: application/json" \
-H "api-key: $0" \
-X POST http://localhost:7878/api/tvshows
sleep 2h
cd /cloudnas/CloudDrive/ali-open/tmm/tmm-tvshows
mv ./*  /cloudnas/CloudDrive/ali-open/TvShows/
docker stop tinymediamanager
