#!/bin/bash
cd /root/bitwarden/data/
git add .
git commit -m "备份bitwarden"
git push origin main
