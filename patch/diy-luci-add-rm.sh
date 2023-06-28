#!/bin/sh

# 替换原argon主题和argon-config主题设置
rm -rf openwrt/feeds/luci/themes/luci-theme-argon
rm -rf openwrt/feeds/luci/applications/luci-app-argon-config
cp -r files/luci-theme-argon openwrt/feeds/luci/themes
cp -r files/luci-app-argon-config openwrt/feeds/luci/applications

# 替换默认主题bootstrap为argon主题
#sed -i 's/bootstrap/argon/ig' openwrt/feeds/luci/collections/luci/Makefile

# 替换update_cloudflare_com_v4.sh
rm -rf openwrt/feeds/packages/net/ddns-scripts/files/update_cloudflare_com_v4.sh
cp files/update_cloudflare_com_v4.sh openwrt/feeds/packages/net/ddns-scripts/files

#修改cloudflared
sed -i '/cloudflared.init $/d' openwrt/feeds/packages/net/cloudflared/Makefile
#sed -i '/init.d/d' openwrt/feeds/packages/net/cloudflared/Makefile
rm openwrt/feeds/packages/net/cloudflared/files/cloudflared.init
#rm -rf openwrt/feeds/packages/net/cloudflared
#cp -r files/cloudflared openwrt/feeds/packages/net

#替换automount自动共享设置文件
rm -rf openwrt/package/lean/automount/files/15-automount
cp -r files/15-automount openwrt/package/lean/automount/files

#修改autosamba中samba4为samba并更改0777权限
sed -i 's/samba4/samba/g' openwrt/package/lean/autosamba/Makefile
sed -i 's/samba4/samba/g' openwrt/package/lean/autosamba/files/20-smb
sed -i 's/0666/0777/' openwrt/package/lean/autosamba/files/20-smb

#修改插件配置文件
sed -i 's#sda#/mnt/sda1#' openwrt/feeds/packages/utils/hd-idle/files/hd-idle.config
sed -i 's/10/5/' openwrt/feeds/packages/utils/hd-idle/files/hd-idle.config
sed -i 's/0/1/' openwrt/feeds/packages/utils/hd-idle/files/hd-idle.config
