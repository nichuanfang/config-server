docker rm -f nginx
docker run \
  -itd \
  --name=nginx \
  --restart=always \
  --network=mynet \
  -p 80:80 \
  -p 443:443 \
  -v /opt/docker/nginx/conf.d/nginx.conf:/etc/nginx/nginx.conf \
  -v /opt/docker/nginx/conf.d/mime.types:/etc/nginx/mime.types \
  -v /opt/docker/nginx/cert:/etc/nginx \
  -v /opt/docker/nginx/html/:/usr/share/nginx/html/ \
  -v /root/assets/img/:/usr/share/img/ \
  -v /root/assets/js/:/usr/share/js/ \
  -v /root/assets/css/:/usr/share/css/ \
  -m 300m nginx
