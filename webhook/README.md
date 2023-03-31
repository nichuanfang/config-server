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
    "id": "hook",
    "execute-command": "/root/webhook/hook.sh",
    "response-message": "I got the payload!",
    "response-headers": [
      {
        "name": "Access-Control-Allow-Origin",
        "value": "*"
      }
    ],
    "pass-arguments-to-command": [
      {
        "source": "payload",
        "name": "repository.name"
      },
      {
        "source": "payload",
        "name": "repository.clone_url"
      },
      {
        "source": "payload",
        "name": "ref"
      }
    ],
    "trigger-rule": {
      "and": [
        {
          "match": {
            "type": "payload-hmac-sha1",
            "secret": "密码",
            "parameter": {
              "source": "header",
              "name": "X-Hub-Signature"
            }
          }
        }
      ]
    }
  }
]
```
* 赋予执行权限 `chmod +x /root/webhook/webhook`
* 赋予执行权限 `chmod +x /root/webhook/start`
* 执行`/root/webhook/start`
* 赋予执行权限 `chmod +x /root/webhook/stop`
* 终止webhook进程 执行`/root/webhook/stop`
* 查看日志: `tail -f /root/webhook/nohup.out`
