#!/bin/bash

cacheFile="~/.kodi/userdata/advancedsettings.xml"
buffermode=1
memorysize=650000000
readfactor=6


#创建缓存文件
if [ ! -f "$cacheFile" ]; then
  touch "$cacheFile"
fi

#设置缓存
cat << EOF > "$cacheFile"
<advancedsettings>
  <cache>
    <buffermode>$buffermode</buffermode>
    <memorysize>$memorysize</memorysize>
    <readfactor>$readfactor</readfactor>
  </cache>
</advancedsettings>
