#!/bin/bash

#统一管理启动的脚本

#缓存检测
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh' | bash

#cloudnas检测
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh' | bash