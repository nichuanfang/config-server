#!/bin/bash
cp -rf /root/bitwarden/data/* /root/code/bitwarden-backup/
cd /root/code/bitwarden-backup
git add .
git commit -m "备份bitwarden"
git push origin main
