# !/bin/bash
# 更新m3u文件

# ====================================================肥羊精选====================================================================

# 4K/8K源
wget https://ghproxy.com/https://raw.githubusercontent.com/youshandefeiyang/IPTV/main/main/IPTV.m3u -O /root/assets/m3u/IPTV.m3u

#  BESTV源
wget https://telegram-feiyangdigital.v1.mk/bestv.m3u -O /root/assets/m3u/bestv.m3u 

# 爱尚源
wget https://ghproxy.com/https://raw.githubusercontent.com/youshandefeiyang/IPTV/main/main/aishang.m3u -O /root/assets/m3u/aishang.m3u 

# CQYX源
wget https://ghproxy.com/https://raw.githubusercontent.com/youshandefeiyang/IPTV/main/main/cqyx.m3u -O /root/assets/m3u/cqyx.m3u

# ======================================================其他======================================================================

# YanG Gather
wget https://ghproxy.com/https://raw.githubusercontent.com/YanG-1989/m3u/main/Gather.m3u -O /root/assets/m3u/Gather.m3u

# Adult
wget https://ghproxy.com/https://raw.githubusercontent.com/YanG-1989/m3u/main/Adult.m3u -O /root/assets/m3u/Adult.m3u

docker restart nginx
