#!/bin/bash

# 配置ubuntu18的python环境

echo "==========================================开始配置python环境..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend

export PYENV_ROOT="${HOME}/.pyenv"

if [ -d "${PYENV_ROOT}" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
fi


# 安装3.7.0版本的python
pyenv install 3.7.0 -v

# 安装3.8.0版本的python
# pyenv install 3.8.0 -v

# 安装3.11.0版本的python
pyenv install 3.11.0 -v

# 设置python和pip的软链接

# 3.7.0
ln -fs /root/.pyenv/versions/3.7.0/bin/python3.7 /usr/bin/python3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/python3.7 /usr/local/bin/python3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/pip3.7 /usr/bin/pip3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/pip3.7 /usr/local/bin/pip3.7

# 3.8.0
# ln -fs /root/.pyenv/versions/3.8.0/bin/python3.8 /usr/bin/python3.8
# ln -fs /root/.pyenv/versions/3.8.0/bin/python3.8 /usr/local/bin/python3.8
# ln -fs /root/.pyenv/versions/3.8.0/bin/pip3.8 /usr/bin/pip3.8
# ln -fs /root/.pyenv/versions/3.8.0/bin/pip3.8 /usr/local/bin/pip3.8

# 3.11.0
ln -fs /root/.pyenv/versions/3.11.0/bin/python3.11 /usr/bin/python3.11
ln -fs /root/.pyenv/versions/3.11.0/bin/python3.11 /usr/local/bin/python3.11
ln -fs /root/.pyenv/versions/3.11.0/bin/pip3.11 /usr/bin/pip3.11
ln -fs /root/.pyenv/versions/3.11.0/bin/pip3.11 /usr/local/bin/pip3.11

# 设置当前目录的python版本
# pyenv local <python-version>
# 取消设置当前目录的python版本
# pyenv local --unset

# python项目虚拟环境管理器
# pyenv-virtualenv的安装及使用:    https://www.jianshu.com/p/c47c225e4bb5
# pip install pyenv-virtualenv

# 创建虚拟环境

# 虚拟环境使用:
# --------------------------------------------------------
# pyenv activate <virtualenv-name>      激活虚拟环境
# pyenv deactivate                      关闭虚拟环境
# --------------------------------------------------------

# 1. 创建python3.8.0的虚拟环境
# 2. 创建python3.11.0
# 3. python3 pip3使用系统自带版本(3.6.9)   python: /usr/bin/python3  pip3: /usr/bin/pip3
#    python pip版本为虚拟环境设置的版本(3.11.0)  python: /root/.pyenv/shims/python   pip: /root/.pyenv/shims/pip
# pyenv virtualenv 3.8.0 ve-3.8.0 && pyenv virtualenv 3.11.0 ve-3.11.0

# 设置默认的python和pip版本为3.11.0
# pyenv global 3.11.0
# ----------------------------caution--------------------------------------------------
# 推荐用法:   服务器运行python脚本/项目时 需要主动激活虚拟环境 脚本/项目运行完成后关闭虚拟环境
# ----------------------------caution--------------------------------------------------

echo "==========================================python环境配置完成!"
