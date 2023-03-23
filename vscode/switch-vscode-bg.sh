# !/bin/bash
# 8以内的随机数
img_prefix = $RANDOM % 8 + 1
img_path = '/root/assets/img/bg'

# 每天定时更换vscode背景图
cp img_path/bg'$img_prefix'.jpg img_path/bg-vscode.jpg
