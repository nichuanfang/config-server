# !/bin/bash
cd /cloudnas/CloudDrive/ali-open/tmm/tmm-tvshows
# 刮削剧集
curl \
-d '[{"action":"update", "scope":{"name":"all"}},{"action":"scrape", "scope":{"name":"new"}}]' \
-H "Content-Type: application/json" \
-H "api-key: $0" \
-X POST http://localhost:7878/api/tvshows