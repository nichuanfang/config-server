@echo on
powershell curl  -o  "D:\soft\Xray-windows-64\config.json"  "https://config.vencenter.cn/client/config.json";
echo "wxray Restart"
taskkill /f /t /fi "imagename eq wxray.exe"
echo "wxray Stop"
start /d "D:\soft\Xray-windows-64" wxray.exe
echo "wxray Start"
exit
