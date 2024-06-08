#!/bin/bash

#统一管理启动的脚本

#缓存检测
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh' | bash

#cloudnas检测
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh' | bash

#更新xray

#需要设置用户名和密码!!! 切记
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_xray.sh' | bash -s "$1" "$2"