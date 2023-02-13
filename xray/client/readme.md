>规则

[geoip](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat)

[geosite](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat)

>白名单模式 Routing 配置方式：
```
"routing": {
  "rules": [
    {
      "type": "field",
      "outboundTag": "Reject",
      "domain": ["geosite:category-ads-all"]
    },
    {
      "type": "field",
      "outboundTag": "Direct",
      "domain": [
        "geosite:private",
        "geosite:apple-cn",
        "geosite:google-cn",
        "geosite:tld-cn",
        "geosite:category-games@cn"
      ]
    },
    {
      "type": "field",
      "outboundTag": "Proxy",
      "domain": ["geosite:geolocation-!cn"]
    },
    {
      "type": "field",
      "outboundTag": "Direct",
      "domain": ["geosite:cn"]
    },
    {
      "type": "field",
      "outboundTag": "Proxy",
      "network": "tcp,udp"
    }
  ]
}
```
>黑名单模式
```
"routing": {
  "rules": [
    {
      "type": "field",
      "outboundTag": "Reject",
      "domain": ["geosite:category-ads-all"]
    },
    {
      "type": "field",
      "outboundTag": "Proxy",
      "domain": ["geosite:gfw", "geosite:greatfire"]
    },
    {
      "type": "field",
      "outboundTag": "Proxy",
      "ip": ["geoip:telegram"]
    },
    {
      "type": "field",
      "outboundTag": "Direct",
      "network": "tcp,udp"
    }
  ]
}
```

