# Webhook For Github

## 参考项目
[adnanh/webhook](https://github.com/adnanh/webhook)

## 配置项

* 下载对应架构的tar包 [Realease](https://github.com/adnanh/webhook/releases)
* 解压 得到可执行文件`webhook`
* 编写`hooks.json`
参考:
```
[
  {
    "id": "MyScripts",
    "execute-command": "/root/scripts/MyScripts.sh"
  }
]
```
* 赋予执行权限 `chmod +x /root/webhook/webhook`
* 赋予执行权限 `chmod +x /root/webhook/start`
* 执行`/root/webhook/start`
* 赋予执行权限 `chmod +x /root/webhook/stop`
* 终止webhook进程 执行`/root/webhook/stop`
* 查看日志: `tail -f /root/webhook/nohup.out`
