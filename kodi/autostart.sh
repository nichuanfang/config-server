#!/bin/bash
(
/storage/frp/frpc -c /storage/frp/frpc.ini
)&

## 启动脚本需要
#1. 检测镜像版本
#2. 检测缓存设置
#3. 更新代理配置
