#
# This is free software, lisence use MIT.
# 
# Copyright (C) 2019 P3TERX <https://p3terx.com>
# Copyright (C) 2020 KFERMercer <KFER.Mercer@gmail.com>
# 
# <https://github.com/KFERMercer/OpenWrt-CI>
#

name: compile OpenWrt

on:
  push:
    branches: 
      - master
  #schedule:
  #  - cron: 0 2 * * *
  watch:
    types: started

jobs:
  build:
    runs-on: ubuntu-20.04
    if: github.event.repository.owner.id == github.event.sender.id

    steps:
      - name: 准备工作
        uses: actions/checkout@master

      - name: 部署编译环境
        env:
          DEBIAN_FRONTEND: noninteractive
        run: |
          sudo -E apt-get -yqq update
          sudo -E apt-get -yqq install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync
          sudo -E apt-get -y autoremove --purge
          sudo -E apt-get clean
      - name: 下载lede源码并移动到根目录
        run: |
          git clone https://github.com/coolsnowwolf/lede
          cp .config ./lede/.config
          mv ./lede/* ./
      - name: 下载其他插件源码到package
        run: |
          git clone https://github.com/kenzok78/jeii  package/jeii
          git clone https://github.com/kjrzxhb/package-other package/package-other
          git clone https://github.com/fw876/helloworld package/helloworld
      - name: 升级安装feeds
        run: |
          ./scripts/feeds update -a
          ./scripts/feeds install -a
      - name: 删除原feeds插件
        run: |
          rm -rf ./feeds/luci/applications/luci-app-udpxy
      - name: 设置5.10内核
        run: |
          sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g' target/linux/ramips/Makefile
      - name: 配置config文件
        run: |
          rm -f ./.config*
          touch ./.config
          # 机型设置:
          cat >> .config <<EOF
          CONFIG_TARGET_ramips=y
          CONFIG_TARGET_ramips_mt7621=y
          CONFIG_TARGET_ramips_mt7621_DEVICE_hiwifi_hc5962=y
          EOF
          # 固件压缩
          cat >> .config <<EOF
          CONFIG_TARGET_IMAGES_GZIP=y
          EOF
          # 内核设置
          cat >> .config <<EOF
          CONFIG_LINUX_5_10=y
          EOF
          # IPv6支持:
          cat >> .config <<EOF
          CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
          CONFIG_PACKAGE_ipv6helper=y
          EOF
          # 多文件系统支持:
          cat >> .config <<EOF
          CONFIG_PACKAGE_kmod-fs-vfat=y
          CONFIG_PACKAGE_kmod-fs-ext4=y
          EOF
          # USB3.0支持:
          cat >> .config <<EOF
          CONFIG_PACKAGE_kmod-usb3=y
          CONFIG_PACKAGE_kmod-usb-storage=y
          CONFIG_PACKAGE_kmod-usb-storage-extras=y
          EOF
          # 工具
          cat >> .config <<EOF
          CONFIG_PACKAGE_htop=y
          # CONFIG_PACKAGE_automount is not set
          CONFIG_PACKAGE_autosamba=y
          CONFIG_PACKAGE_openssh-sftp-server=y
          EOF
          # 主题
          cat >> .config <<EOF
          CONFIG_PACKAGE_luci-theme-argonne=y
          CONFIG_PACKAGE_luci-theme-bootstrap=y
          EOF
          # 常用插件
          cat >> .config <<EOF
          CONFIG_PACKAGE_luci-app-accesscontrol=y
          CONFIG_PACKAGE_luci-app-adbyby-plus=y
          CONFIG_PACKAGE_luci-app-advancedsetting=y
          CONFIG_PACKAGE_luci-app-arpbind=y
          CONFIG_PACKAGE_luci-app-autoreboot=y
          CONFIG_PACKAGE_luci-app-baidupcs-web=y
          CONFIG_PACKAGE_luci-app-ddns=y
          CONFIG_PACKAGE_luci-app-diskman=y
          CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y
          CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk=y
          CONFIG_PACKAGE_luci-app-easymesh=y
          CONFIG_PACKAGE_luci-app-nft-qos=y
          CONFIG_PACKAGE_luci-app-frpc=y
          CONFIG_PACKAGE_luci-app-wol=y
          CONFIG_PACKAGE_luci-app-upnp=y
          CONFIG_PACKAGE_luci-app-jd-dailybonus=y
          CONFIG_PACKAGE_luci-app-filetransfer=y
          CONFIG_PACKAGE_luci-app-firewall=y
          CONFIG_PACKAGE_luci-app-ramfree=y
          CONFIG_PACKAGE_luci-app-hd-idle=y
          CONFIG_PACKAGE_luci-app-mwan3=y
          CONFIG_PACKAGE_luci-app-nlbwmon=y
          CONFIG_PACKAGE_luci-app-omcproxy=y
          CONFIG_PACKAGE_luci-app-syncdial=y
          CONFIG_PACKAGE_luci-app-samba=y
          CONFIG_PACKAGE_luci-app-ssr-plus=y
          CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Libev_Client=y
          CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y
          CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Xray=y
          CONFIG_PACKAGE_luci-app-turboacc=y
          CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_OFFLOADING=y
          # CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE_DRV is not set
          # CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE is not set
          CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_BBR_CCA=y
          # CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_DNSFORWARDER is not set
          # CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_DNSPROXY is not set
          CONFIG_PACKAGE_luci-app-ttyd=y
          CONFIG_PACKAGE_luci-app-udpxy=y
          CONFIG_PACKAGE_luci-app-unblockmusic=y
          CONFIG_PACKAGE_luci-app-unblockmusic_INCLUDE_UnblockNeteaseMusic_Go=y
          CONFIG_PACKAGE_luci-app-usb-printer=y
          CONFIG_PACKAGE_luci-app-usb3disable=y
          CONFIG_PACKAGE_luci-app-vsftpd=y
          CONFIG_PACKAGE_luci-app-wrtbwmon=y
          CONFIG_PACKAGE_luci-app-zerotier=y
          EOF
          sed -i 's/^[ \\t]*//g' ./.config
          make defconfig
      - name: 下载软件包
        run: |
          make download -j8
          find dl -size -1024c -exec ls -l {} \;
          find dl -size -1024c -exec rm -f {} \;
      - name: 开始编译固件
        run: |
          echo -e "$(nproc) thread build."
          make -j$(nproc) V=s
      - name : 上传bin文件夹(固件+ipk)到 github actions
        uses: actions/upload-artifact@master
        with:
          name: OpenWrt_LEDE_firmware
          path: bin/
