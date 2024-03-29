import os
import sys

# $VPS_DOMAIN $QX_GIST_ID $QX_USERNAME $QX_PASSWORD
# qx域名
VPS_DOMAIN = sys.argv[1]
# # qx gist id
QX_SUBSCRIBE_ID = sys.argv[2]
# # qx用户名
QX_USERNAME = sys.argv[3]
# # qx密码
QX_PASSWORD = sys.argv[4]

# 读取上一级目录的qx.conf
with open('../qx.conf', 'r+',encoding='utf-8') as f:
    conf = f.read()
# 替换qx.conf中的qx域名
conf = conf.replace('[VPS_DOMAIN]', f'www.{VPS_DOMAIN}')
# # 替换qx.conf中的qx gist id
conf = conf.replace('[QX_SUBSCRIBE_ID]', QX_SUBSCRIBE_ID)
# # 替换qx.conf中的qx用户名
conf = conf.replace('[QX_USERNAME]', QX_USERNAME)
# # 替换qx.conf中的qx密码
conf = conf.replace('[QX_PASSWORD]', QX_PASSWORD)
# 写入qx.conf
with open(os.path.join('../qx.conf'), 'w+',encoding='utf-8') as f:
    f.write(conf)