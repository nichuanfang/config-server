docker stop nginx
/root/.acme.sh/acme.sh --issue \
  -d "www.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/www-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/www-vencenter-cn-key.pem \
  --standalone \
  --force
/root/.acme.sh/acme.sh --issue \
  -d "img.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/img-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/img-vencenter-cn-key.pem \
  --standalone \
  --force
/root/.acme.sh/acme.sh --issue \
  -d "js.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/js-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/js-vencenter-cn-key.pem \
  --standalone \
  --force
/root/.acme.sh/acme.sh --issue \
  -d "css.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/css-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/css-vencenter-cn-key.pem \
  --standalone \
  --force
/root/.acme.sh/acme.sh --issue \
  -d "m3u.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/m3u-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/m3u-vencenter-cn-key.pem \
  --standalone \
  --force
/root/.acme.sh/acme.sh --issue \
  -d "webhook.vencenter.cn" \
  --server letsencrypt \
  --keylength ec-256 \
  --fullchain-file /opt/docker/nginx/cert/webhook-vencenter-cn.pem \
  --key-file /opt/docker/nginx/cert/webhook-vencenter-cn-key.pem \
  --standalone \
  --force

echo "Certificates Renewed"
chmod 600 /opt/docker/nginx/cert/*.pem
echo "Read Permission Granted for Private Key"
docker start nginx
