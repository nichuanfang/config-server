Invoke-WebRequest -Uri "https://config.vencenter.cn/client/config.json" -Headers @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("用户名:密码" ))} -Method Get -OutFile 'D:\soft\Xray-windows-64\config.json'
& .\restart.bat
