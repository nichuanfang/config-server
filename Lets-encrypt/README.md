# 泛域名证书申请 (Ubuntu 18)

> 全网 HTTPS 时代就要到来，[Let’s Encrypt](https://letsencrypt.org/) 三个月有效期的免费 HTTPS 证书现在支持泛域名了，我们可以通过 [Certbot](https://certbot.eff.org/) 非常方便的申请和更新证书。网上很多关于 Certbot 的文章，但是关于泛域名证书的自动更新很少提及，或者很多误区，这里简单的讲解一下。

## Certbot 安装

安装非常简单，只要进入 Certbot 官网选择对应的系统和 Web 服务软件就会提示如何安装，按照提示操作就可以了。

```bash
apt-get update
apt-get install software-properties-common
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install python3-certbot-nginx
```

## 申请泛域名证书

这里用到了一个开源工具：[certbot-letencrypt-wildcardcertificates-alydns-au](https://github.com/ywdblog/certbot-letencrypt-wildcardcertificates-alydns-au)工具就不介绍了，点开链接作者写的很详细了，看看怎么用吧

### 1. 下载

```bash
cd ~/code
git clone https://github.com/ywdblog/certbot-letencrypt-wildcardcertificates-alydns-au
mv certbot-letencrypt-wildcardcertificates-alydns-au certbot
cd certbot
chmod 777 au.sh
```

### 2. 配置

#### (1) domain.ini

如果domain.ini文件没有你的根域名，请自行添加

#### (2) DNS API 密钥

ALY_KEY 和 ALY_TOKEN：阿里云 [API key 和 Secrec 官方申请文档](https://help.aliyun.com/knowledge_detail/38738.html)
<img width="914" alt="屏幕截图 2023-03-30 235738" src="https://user-images.githubusercontent.com/37105637/228915797-20625aa4-5263-4817-9e11-90f7a9484999.png">

#### (3) 修改au.sh的python版本
![image](https://user-images.githubusercontent.com/37105637/228916010-d1fcf8c3-404b-4d2a-8712-98cbc979b59e.png)

#### (4) 选择运行环境

Python(支持2.7和3.7，无需任何第三方库) Python操作阿里云DNS，增加/清空DNS。
 `au.sh python aly add/clean`
 
#### (5) 注释掉报错代码
![image](https://user-images.githubusercontent.com/37105637/228916235-4e1b4a31-a4c6-4545-8163-17452ceb5d90.png)

### 3. 申请证书

测试是否有错误：

```bash
certbot certonly  -d *.example.com --manual --preferred-challenges dns --dry-run  --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh php aly clean"
```

**实际申请:**

```bash
certbot certonly  -d *.example.com --manual --preferred-challenges dns --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
```

### 4. 续期证书

#### 对机器上所有证书 renew

```bash
certbot renew  --manual --preferred-challenges dns --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
```

#### 对某一张证书进行续期

```bash
#先看看机器上有多少证书：
certbot certificates
#记住证书名，比如 simplehttps.com，然后运行下列命令 renew
certbot renew --cert-name simplehttps.com  --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
```

## 加入 crontab

编写证书更新脚本

```bash
#!/bin/bash
docker stop nginx
certbot renew --cert-name vencenter.cn --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
cp /etc/letsencrypt/live/vencenter.cn/fullchain.pem /opt/docker/nginx/cert
cp /etc/letsencrypt/live/vencenter.cn/privkey.pem /opt/docker/nginx/cert
echo "Certificates Renewed"
chmod 777 /opt/docker/nginx/cert/*.pem
echo "Read Permission Granted for Private Key"
docker start nginx
```
添加执行权限  `chmod +x /opt/docker/nginx/cert/renew.sh`

定时任务 `crontab -e`:

```bash
#证书有效期<30天才会renew
0 4 1 * * /bin/bash /opt/docker/nginx/cert/renew.sh
```
