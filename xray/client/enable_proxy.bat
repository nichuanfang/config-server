@echo off 
echo 开始开启系统代理，请稍候...
echo=
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "127.0.0.1:10809" /f >nul 2>nul
echo 系统代理已开启，请按任意键关闭本窗口...
pause>nul
