#!/bin/sh

#修改feeds.conf.default,在telephony字段行后一行添加SSR
#sed -i '/telephony/a src-git helloworld https://github.com/fw876/helloworld.git' openwrt/feeds.conf.default
sed -i '/^#.*helloworld/s/^#//' openwrt/feeds.conf.default
#修改feeds.conf.default,在helloworld字段行后一行添加我的库package
sed -i '/helloworld/a src-git package https://github.com/kjrzxu/package.git' openwrt/feeds.conf.default

#修改autosamba中samba4为samba并更改0777权限
sed -i 's/samba4/samba/g' openwrt/package/lean/autosamba/Makefile
sed -i 's/samba4/samba/g' openwrt/package/lean/autosamba/files/20-smb
sed -i 's/0666/0777/' openwrt/package/lean/autosamba/files/20-smb

#替换automount
#rm -rf openwrt/package/lean/automount/files/15-automount
#cp -r files/15-automount openwrt/package/lean/automount/files

#修改默认插件
#sed -i 's/luci-app-filetransfer //' openwrt/include/target.mk
#sed -i '/ca-certificates/s/$/ \\/' openwrt/include/target.mk
#sed -i '/ca-certificates/s/$/\n/' openwrt/include/target.mk
#sed -i '/ca-certificates/r files/target.txt' openwrt/include/target.mk
