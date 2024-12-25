#!/bin/bash
cd ~/data/uptime_kuma || exit
git add .
git commit -m "备份uptime"
git push origin main
