docker run -d \
      --name clouddrive \
      --restart unless-stopped \
      --env CLOUDDRIVE_HOME=/Config \
      -v /storage/cloudnas/data:/CloudNAS:shared \
      -v /storage/cloudnas/config:/Config \
      --network host \
      --pid host \
     --privileged \
     --device /dev/fuse:/dev/fuse \
     cloudnas/clouddrive2-unstable
