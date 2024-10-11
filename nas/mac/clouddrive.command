#!/bin/bash

# 运行 clouddrive2 并放入后台，同时将输出重定向到日志文件
/Applications/clouddrive/clouddrive > /Applications/clouddrive/clouddrive2.log 2>&1 &

# 在macos的系统登陆启动设置选中该项