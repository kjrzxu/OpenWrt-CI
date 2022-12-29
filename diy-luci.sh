#!/bin/sh

#添加界面主页IPTV分类和顺序
sed -i '/"VPN"/a entry({"admin", "iptv"}, firstchild(), _("IPTV"), 45).index = true' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/index.lua
sed -i '/"VPN"/s/$/\n/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/index.lua
sed -i '/"IPTV"/s/^/\t/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/index.lua

#修改界面主页分类和顺序
sed -i 's/page.order = 30/page.order = 42/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/network.lua
sed -i 's/page.order = 50/page.order = 43/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/network.lua
sed -i 's/_("Diagnostics"/_("网络诊断"/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/network.lua
sed -i 's/page.order = 60/page.order = 41/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/network.lua

sed -i 's/_("Scheduled Tasks"), 46/_("Scheduled Tasks"), 51/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
sed -i 's#_("Backup / Flash Firmware"#_("备份升级"#' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
sed -i 's/_("Reboot"/_("系统重启"/' openwrt/feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# 把bootstrap替换成argon为源码必选主题
sed -i 's/bootstrap/argon/ig' openwrt/feeds/luci/collections/luci/Makefile

#修改插件名称并调整顺序
sed -i 's/_("ShadowSocksR Plus+"/_("科学上网Plus"/' openwrt/feeds/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i '101s/x86_64/x86_64||mipsel/' openwrt/feeds/helloworld/luci-app-ssr-plus/Makefile
sed -i '127s/n/y/' openwrt/feeds/helloworld/luci-app-ssr-plus/Makefile
sed -i '161s/n/y/' openwrt/feeds/helloworld/luci-app-ssr-plus/Makefile

sed -i 's/_("Internet Access Schedule Control"/_("时间控制"/' openwrt/feeds/luci/applications/luci-app-accesscontrol/luasrc/controller/mia.lua
sed -i 's/"services"/"control"/g' openwrt/feeds/luci/applications/luci-app-accesscontrol/luasrc/controller/mia.lua

sed -i 's/_("ADBYBY Plus +"/_("广告屏蔽Plus"/' openwrt/feeds/luci/applications/luci-app-adbyby-plus/luasrc/controller/adbyby.lua

sed -i 's/_("AliyunDrive WebDAV"/_("阿里云盘"/' openwrt/feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc/controller/aliyundrive-webdav.lua
sed -i 's/"services"/"nas"/g' openwrt/feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc/controller/aliyundrive-webdav.lua

sed -i 's#"IP/MAC Binding"), 45#"MAC绑定"), 65#' openwrt/feeds/luci/applications/luci-app-arpbind/luasrc/controller/arpbind.lua

sed -i 's/_("BaiduPCS Web"), 300/_("百度网盘"), 20/' openwrt/feeds/luci/applications/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/_("Dynamic DNS"), 59/_("动态 DNS"), 105/' openwrt/feeds/luci/applications/luci-app-ddns/luasrc/controller/ddns.lua

sed -i 's/_("EASY MESH"), 60/_("简单MESH"), 80/' openwrt/feeds/luci/applications/luci-app-easymesh/luasrc/controller/easymesh.lua
sed -i 's/_("Firewall"), 60/_("Firewall"), 35/' openwrt/feeds/luci/applications/luci-app-firewall/luasrc/controller/firewall.lua

sed -i 's/_("Guest-wifi"), 19/_("Guest-wifi"), 70/' openwrt/feeds/luci/applications/luci-app-guest-wifi/luasrc/controller/guest-wifi.lua

sed -i 's/_("HDD Idle"), 60/_("HDD Idle"), 70/' openwrt/feeds/luci/applications/luci-app-hd-idle/luasrc/controller/hd_idle.lua
sed -i 's/"services"/"nas"/g' openwrt/feeds/luci/applications/luci-app-hd-idle/luasrc/controller/hd_idle.lua

sed -i 's/_("omcproxy")/_("omcproxy"), 10/' openwrt/feeds/luci/applications/luci-app-omcproxy/luasrc/controller/omcproxy.lua
sed -i 's/"services"/"iptv"/g' openwrt/feeds/luci/applications/luci-app-omcproxy/luasrc/controller/omcproxy.lua

sed -i 's/"services"/"nas"/g' openwrt/feeds/luci/applications/luci-app-samba/luasrc/controller/samba.lua

sed -i 's/"services"/"nas"/g' openwrt/feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua

sed -i 's/"Socat"), 100/"端口转发"), 100/' openwrt/feeds/luci/applications/luci-app-socat/luasrc/controller/socat.lua

sed -i 's/"TTYD Terminal"), 10/"命令终端"), 55/' openwrt/feeds/luci/applications/luci-app-ttyd/luasrc/controller/terminal.lua

sed -i 's/"Turbo ACC Center"), 101/"网络加速"), 101/' openwrt/feeds/luci/applications/luci-app-turboacc/luasrc/controller/turboacc.lua

sed -i 's/_("udpxy")/_("IPTV单播"), 99/' openwrt/feeds/luci/applications/luci-app-udpxy/luasrc/controller/udpxy.lua

sed -i 's/_("uHTTPd")/_("uhttpd管理"), 102/' openwrt/feeds/luci/applications/luci-app-uhttpd/luasrc/controller/uhttpd/uhttpd.lua

sed -i 's/_("Unblock Netease Music"), 50/_("解锁网易歌曲"), 50/' openwrt/feeds/luci/applications/luci-app-unblockmusic/luasrc/controller/unblockmusic.lua

sed -i 's/_("UPnP")/_("UPNP端口转发"), 101/' `egrep "UPnP" openwrt/feeds/luci/applications/luci-app-upnp/luasrc/controller/upnp.lua

sed -i 's/_("USB Printer Server"), 50/_("USB 打印"), 100/' openwrt/feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/"网络存储"/"存储"/' openwrt/feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po

sed -i 's/_("KMS Server"), 100/_("KMS 激活"), 110/' openwrt/feeds/luci/applications/luci-app-vlmcsd/luasrc/controller/vlmcsd.lua

sed -i 's/_("FTP Server")/_("FTP服务器"), 80/' openwrt/feeds/luci/applications/luci-app-vsftpd/luasrc/controller/vsftpd.lua

sed -i 's/"网络存储"/"存储"/' openwrt/feeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po

sed -i 's/"services"/"control"/g' openwrt/feeds/luci/applications/luci-app-wol/luasrc/controller/wol.lua

#sed -i 's/_("ZeroTier"), 99/"ZeroTier"), 120/' openwrt/feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
#sed -i 's/"vpn", "zerotier"/"services", "zerotier"/g' openwrt/feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua

#修改配置文件