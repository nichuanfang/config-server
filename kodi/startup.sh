#!/bin/bash


#github代理
GITHUB_PROXY="proxy.jaychou.site"
#用户名 用于下载xray配置文件和geo文件
USERNAME="你的用户名"
#密码  用于下载xray配置文件和geo文件
PASSWORD="你的密码"


#统一管理启动的脚本

#缓存检测
curl -s "https://$GITHUB_PROXY/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh" | bash -s $GITHUB_PROXY

#cloudnas检测
curl -s "https://$GITHUB_PROXY/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh" | bash -s $GITHUB_PROXY

#更新xray

#需要设置用户名和密码!!! 切记  注意: 参数$1和$2不能加双引号  否则coreelec不识别!
curl -s "https://$GITHUB_PROXY/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_xray.sh" | bash -s $GITHUB_PROXY $USERNAME $PASSWORD