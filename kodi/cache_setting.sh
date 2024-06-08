#!/bin/bash

cacheFile=/storage/.kodi/userdata/advancedsettings.xml

if [ ! -f "$cacheFile" ]; then
touch "$cacheFile"
cat << EOF > "$cacheFile"
<advancedsettings>
  <cache>
    <buffermode>1</buffermode>
    <memorysize>314572800</memorysize>
    <readfactor>25</readfactor>
  </cache>
</advancedsettings>
EOF
reboot
fi