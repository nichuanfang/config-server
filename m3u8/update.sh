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

# ======================================================稳定=======================================================================

# 除成人内容以外的已知频道.m3u
wget https://iptv-org.github.io/iptv/index.m3u -O /root/assets/m3u/index.m3u

# 包括完整内容所有已知频道.m3u
wget https://iptv-org.github.io/iptv/index.nsfw.m3u -O /root/assets/m3u/index.nsfw.m3u

# ======================================================国内2023年2月更新=======================================================================
wget https://raw.githubusercontent.com/imDazui/Tvlist-awesome-m3u-m3u8/master/m3u/%E5%9B%BD%E5%86%85%E7%94%B5%E8%A7%86%E5%8F%B02023.m3u8 -O /root/assets/m3u/latest.m3u

# ============================================各地运营商 IPTV 直播源，速度稳定画质好，选择你所在地宽带运营商========================================
wget https://raw.githubusercontent.com/imDazui/Tvlist-awesome-m3u-m3u8/master/m3u/%E6%B5%99%E6%B1%9F%E7%9C%81%E6%9D%AD%E5%B7%9E%E5%B8%82%E7%A7%BB%E5%8A%A8.m3u -O /root/assets/m3u/hangzhou.m3u

docker restart nginx
