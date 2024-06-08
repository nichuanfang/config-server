#!/bin/bash

## 启动脚本需要
#1. 检测镜像版本
#2. 检测缓存设置
#3. 更新代理配置

(
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh' | bash
curl -s 'https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh' | bash
)&
