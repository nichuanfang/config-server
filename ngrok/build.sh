export NGROK_DOMAIN="ngrok.baidu.com" #你自己的二级域名
cd /usr/local/ngrok/ #这里是你自己的ngrok路径（之前clone下载的）
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048
openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
cp rootCA.pem assets/client/tls/ngrokroot.crt
cp device.crt assets/server/tls/snakeoil.crt
cp device.key assets/server/tls/snakeoil.key

make release-server
#下面这些是生成的客户端，可根据自己的客户端进行挑选，不用全部都导出
#GOOS=linux GOARCH=386 make release-client 
GOOS=linux GOARCH=amd64 make release-client
#GOOS=windows GOARCH=386 make release-client
GOOS=windows GOARCH=amd64 make release-client
#GOOS=darwin GOARCH=386 make release-client
#GOOS=darwin GOARCH=amd64 make release-client
#GOOS=linux GOARCH=arm make release-client
