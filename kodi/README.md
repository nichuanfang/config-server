刷COREELEC系统 [官网](https://coreelec.org/)

## update_cloudnas.sh脚本说明

可以手动更新cloudnas版本 如果在ios的SSH终端调用该脚本 使用以下命令:

```bash
curl -s https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/update_cloudnas.sh | bash
```

## cache_setting.sh脚本说明

手动的设置缓存:

```bash
curl -s https://proxy.jaychou.site/https://raw.githubusercontent.com/nichuanfang/config-server/master/kodi/cache_setting.sh | bash
```

## autostart.sh脚本食用说明

需要放在 **/storage/.config**目录下.需要配合**startup.sh**脚本使用

## startup.sh脚本食用说明

开机启动 真正执行的代码在这里 目前有以下功能:

- 自动更新**cloudnas**镜像版本
- 自动检测缓存(300m)是否设置 如没有设置会自动设置
- 自动启动**xray-core[client]**  代理客户端,且自动更新xray客户端镜像版本和配置文件

> tips: 需要将`autostart.sh`和`startup.sh`同时放入`/storage/.config`目录 且需要使用 `chmod +x`赋予他们可执行权限

  
