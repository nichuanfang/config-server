#!/bin/bash
cp -rf /root/bitwarden/data/* /root/code/bitwarden-backup/
cd /root/code/bitwarden-backup || exit
git add .
git commit -m "备份bitwarden"
git push origin main
