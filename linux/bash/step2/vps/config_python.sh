#!/bin/bash

# 配置ubuntu18的python环境

echo "==========================================开始配置python环境..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock-frontend
sudo apt-get install -y gcc make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
# 安装pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# 添加到环境变量

echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >>~/.bashrc

# 刷新配置
source ~/.bashrc

# 配置虚拟环境
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc
source ~/.bashrc

# 安装3.7.0版本的python
pyenv install 3.7.0 -v

# 安装3.8.0版本的python
pyenv install 3.8.0 -v

# 安装3.11.0版本的python
pyenv install 3.11.0 -v

# 设置python和pip的软链接

# 3.7.0
ln -fs /root/.pyenv/versions/3.7.0/bin/python3.7 /usr/bin/python3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/python3.7 /usr/local/bin/python3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/pip3.7 /usr/bin/pip3.7
ln -fs /root/.pyenv/versions/3.7.0/bin/pip3.7 /usr/local/bin/pip3.7

# 3.8.0
ln -fs /root/.pyenv/versions/3.8.0/bin/python3.8 /usr/bin/python3.8
ln -fs /root/.pyenv/versions/3.8.0/bin/python3.8 /usr/local/bin/python3.8
ln -fs /root/.pyenv/versions/3.8.0/bin/pip3.8 /usr/bin/pip3.8
ln -fs /root/.pyenv/versions/3.8.0/bin/pip3.8 /usr/local/bin/pip3.8

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
