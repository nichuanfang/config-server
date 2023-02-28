#!/bin/bash

cacheFile=/storage/.kodi/userdata/advancedsettings.xml

if [ ! -f "$cacheFile" ]; then
  touch "$cacheFile"
fi

cat << EOF > "$cacheFile"
<advancedsettings>
  <cache>
    <buffermode>3</buffermode>
    <memorysize>650000000</memorysize>
    <readfactor>20</readfactor>
  </cache>
</advancedsettings>
EOF
