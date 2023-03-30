#!/bin/bash
cd /root/code/xray-parser
if [ $1 == refs/heads/client ]; then
    git checkout client
    echo 'client分支已检出'
elif [ $1 == refs/heads/server ]; then
    git checkout server
    echo 'server分支已检出'
fi
bash build.sh
