#!/bin/bash

cacheFile=/storage/.kodi/userdata/advancedsettings.xml

if [ ! -f "$cacheFile" ]; then
  touch "$cacheFile"
fi

cat << EOF > "$cacheFile"
<advancedsettings>
  <cache>
    <buffermode>1</buffermode>
    <memorysize>650000000</memorysize>
    <readfactor>6</readfactor>
  </cache>
</advancedsettings>
