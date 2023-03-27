#!/bin/bash

# 杀进程脚本

#检查是否有输入参数
[ -z "$1" ] && echo "you should input the process name !" && exit 0
#杀进程
ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill -9
echo '已停止进程:'$1
exit 0
