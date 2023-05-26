# !/bin/bash

# github登录脚本 for Ubuntu18.0

# 1. 需要先在~/.bashrc中配置环境变量 GH_TOKEN='你的token' (To use gh in GitHub Actions, add GH_TOKEN: ${{ github.token }} to "env".)
# 2. source ~/.bashrc  刷新配置 使之生效
# 3. 安装github command line tool(Github Cli) : `snap install  gh`

# -h 指定登录的域名
gh auth login -h GitHub.com
