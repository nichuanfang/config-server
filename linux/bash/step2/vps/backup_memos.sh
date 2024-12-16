#!/bin/bash
cd ~/data/memos || exit
git add .
git commit -m "备份memos"
git push
