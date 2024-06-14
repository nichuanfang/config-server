#!/bin/bash
cd /root/redis/data || exit
git add .
git commit -m "备份redis"
git push
