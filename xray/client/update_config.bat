Invoke-WebRequest -Uri "https://config.vencenter.cn/client/config.json" -Headers @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("18326186224:0820nCf9270" ))} -Method Get -OutFile 'D:\soft\Xray-windows-64\config.json'
& .\restart.bat
