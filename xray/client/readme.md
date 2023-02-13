>规则

[geoip](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat)

[geosite](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat)

>Routing 配置
```
"routing": {
    "domainStrategy": "IPIfNonMatch",
    "domainMatcher": "mph",
    "rules": [
      {
        "type": "field",
        "outboundTag": "Reject",
        "domain": ["geosite:category-ads-all"]
      },
      {
        "type": "field",
        "outboundTag": "Proxy",
        "domain": ["geosite:geolocation-!cn"]
      },
      {
        "type": "field",
        "outboundTag": "Direct",
        "domain": ["geosite:cn", "geosite:private"]
      },
      {
        "type": "field",
        "outboundTag": "Direct",
        "ip": ["geoip:cn", "geoip:private"]
      }
    ]
}
```


