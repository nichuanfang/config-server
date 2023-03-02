@echo on
echo "wxray Restart"
taskkill /f /t /fi "imagename eq wxray.exe"
echo "wxray Stop"
start /d "你的wxray.exe所在全路径" wxray.exe
echo "wxray Start"
exit
