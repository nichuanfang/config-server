#!/bin/bash

# 配置ubuntu18的python环境

echo "==========================================开始配置python环境..."

# gcc编译器
apt-get install build-essential -y

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

# python项目虚拟环境管理器
pip install pyenv-virtualenv

echo "==========================================python环境配置完成!"
