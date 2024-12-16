#!/bin/bash
cd ~/data/bitwarden || exit
git add .
git commit -m "备份bitwarden"
git push origin main
