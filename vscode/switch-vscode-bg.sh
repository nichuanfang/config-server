#!/bin/bash
# 每天定时更换vscode背景图
x=$((RANDOM % 8 + 1))
img_path="/root/assets/img/bg/bg${x}.jpg"
dest_path="/root/assets/img/bg/bg-vscode.jpg"
cp $img_path $dest_path
