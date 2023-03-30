@echo on
powershell curl  -o  "D:\soft\Xray-windows-64\config.json"  "客户端配置文件地址";
echo "wxray Restart"
taskkill /f /t /fi "imagename eq wxray.exe"
echo "wxray Stop"
start /d "D:\soft\Xray-windows-64" wxray.exe
echo "wxray Start"
exit
