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

#### (3) 选择运行环境

Python(支持2.7和3.7，无需任何第三方库) Python操作阿里云DNS，增加/清空DNS。
 `au.sh python aly add/clean`

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

定时任务 `crontab -e`:

```bash
#证书有效期<30天才会renew，所以crontab可以配置为1天或1周
1 */1 * * root certbot renew --manual --preferred-challenges dns  --manual-auth-hook "/root/code/certbot/au.sh python aly add" --manual-cleanup-hook "/root/code/certbot/au.sh python aly clean"
```
