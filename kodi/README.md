刷COREELEC系统 [官网](https://coreelec.org/)

## `update_cloudnas.sh`脚本说明
可以手动更新cloudnas版本 如果在ios的SSH终端调用该脚本 使用以下命令:
```bash
curl -s https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh | bash
```

## `cache_setting.sh`脚本说明
手动的设置缓存:
```bash
curl -s https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh | bash
```

## `autostart.sh`脚本食用说明 
需要放在 **/storage/.config**目录下.该脚本可以无感知做到: 自动更新cloudnas版本,配置xray代理,配置缓存~

 