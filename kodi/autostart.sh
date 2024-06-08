#!/bin/bash
(
bash -c  "$(curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh')"
bash -c  "$(curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh')"
)&
