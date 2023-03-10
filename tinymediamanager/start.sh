docker run \
    --name=tinymediamanager \
    --restart=always \
    --network=mynet \
    -it \
    -d  \
    -p 4000:4000 \
    -p 7878:7878 \
    -e USER_ID=0 \
    -e GROUP_ID=0   \
    -v /root/tmm/data:/data       \
    -v /cloudnas/CloudDrive/ali-open/tmm/tmm-movies:/media/ali-movies \
    -v /cloudnas/CloudDrive/ali-open/tmm/tmm-tvshows:/media/ali-tvshows \
    -v /cloudnas/CloudDrive/PikPak/media/tmm/tmm-movies:/media/pikpak-movies \
    -v /cloudnas/CloudDrive/PikPak/media/tmm/tmm-tvshows:/media/pikpak-tvshows \
    -v /root/tmm/addons:/app/addons \
    tinymediamanager/tinymediamanager:latest
