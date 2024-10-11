#!/bin/bash

# 定义PID文件的路径
PID_FILE="/Applications/clouddrive/clouddrive2.pid"

# 检查PID文件是否存在
if [ -f "$PID_FILE" ]; then
  # 读取PID文件中的进程ID
  PID=$(cat "$PID_FILE")

  # 检查进程是否存在
  if ps -p $PID > /dev/null; then
    # 终止进程
    kill $PID
    echo "clouddrive进程 (PID: $PID) 已终止"

    # 删除PID文件
    rm "$PID_FILE"
  else
    echo "未找到clouddrive进程 (PID: $PID)，可能已经终止"

    # 删除失效的PID文件
    rm "$PID_FILE"
  fi
else
  echo "未找到PID文件，clouddrive可能未运行"
fi
