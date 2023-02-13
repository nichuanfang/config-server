>规则

[geoip](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat)

[geosite](https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat)

>白名单模式 Routing 配置方式：
```
"routing": {
    "domainStrategy": "IPIfNonMatch",
    "domainMatcher": "mph",
    "rules": [            
      {
        "type": "field",
        "domain": [
          "aliyundrive.net" 
        ],
        "outboundTag": "direct"
      },
      {
       
        "type": "field",
        "ip": ["geoip:cn","geoip:private"],
        "outboundTag": "block"
      },
      {
        "type": "field",
        "domain": [
          "geosite:cn,"geosite:private"
        ],
        "outboundTag": "block" 
      },
      {
        "type": "field",
        "domain": [
          "geosite:category-ads-all" 
        ],
        "outboundTag": "block"
      }
      
    ]
   }
```

