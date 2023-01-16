1. docker exec --user www-data -it koel bash

2. php artisan koel:init --no-assets

3. default username: admin@koel.dev
   default password: KoelIsCool

4. 默认music路径:  /var/snap/docker/common/var-lib-docker/volumes/koel_music/_data/__KOEL_UPLOADS__

5. 添加音乐可以直接从UI界面或者上传到默认music路径中,为防止数据不同步,删除音乐不能直接删除该路径下的音乐,需要走api(UI或者手机APP)
