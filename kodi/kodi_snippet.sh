#!/bin/bash

wget "https://ghproxy.com/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh" -O ~

cd ~

chmod +x cache_setting.sh

sh cache_setting.sh "$0"

rm -f cache_setting.sh
