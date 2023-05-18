#!/bin/bash

# 配置ubuntu18的python环境

echo "==========================================开始配置python环境..."

# gcc编译器
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

# 安装pyenv
curl https://pyenv.run | bash

# 添加到环境变量

echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
echo 'eval "$(pyenv init -)"' >>~/.bashrc

echo 'export PYENV_ROOT="$HOME/.pyenv"' >>/etc/profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>/etc/profile

echo 'eval "$(pyenv init -)"' >>/etc/profile

# 刷新配置
source ~/.bashrc
source /etc/profile

# 安装3.8.0版本的python
pyenv install 3.8.0 -v

# 安装3.11.0版本的python
pyenv install 3.11.0 -v

# 设置当前目录的python版本
# pyenv local 3.11.0

# python项目虚拟环境管理器
# pyenv-virtualenv的安装及使用:    https://www.jianshu.com/p/c47c225e4bb5
# pip install pyenv-virtualenv

# 创建虚拟环境

# 虚拟环境使用:
# --------------------------------------------------------
# pyenv activate <virtualenv-name>      激活虚拟环境
# pyenv deactivate                      关闭虚拟环境
# --------------------------------------------------------

# 创建python3.8.0的虚拟环境
pyenv virtualenv 3.8.0 ve-3.8.0
# 创建python3.11.0
pyenv virtualenv 3.11.0 ve-3.11.0

# 取消设置当前目录的python版本
# pyenv local --unset

# python3 pip3使用系统自带版本(3.6.9)   python: /usr/bin/python3  pip3: /usr/bin/pip3
# python pip版本为虚拟环境设置的版本(3.11.0)  python: /root/.pyenv/shims/python   pip: /root/.pyenv/shims/pip
pyenv activate ve-3.11.0

echo "==========================================python环境配置完成!"
