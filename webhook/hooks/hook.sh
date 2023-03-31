#!/bin/bash

# 入口
# 公共的hook

# 如果没有该项目 git clone到/root/code中
# 有该项目 执行git pull 更新文件
# 执行build.sh

if [ ! -d "/root/code/$1" ]; then
    cd /root/code
    git clone $2 
    cd $1
else
    cd /root/code/$1
    # 检出指定分支
    git checkout ${3:11}
    git pull
fi
# 执行指定脚本
bash build.sh
