#!/bin/bash
#每天更新ip库
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O /usr/local/share/xray/geoip.dat
systemctl restart xray
