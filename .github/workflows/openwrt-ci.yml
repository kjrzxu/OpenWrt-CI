#
# This is free software, lisence use MIT.
# 
# Copyright (C) 2019 P3TERX <https://p3terx.com>
# Copyright (C) 2020 KFERMercer <KFER.Mercer@gmail.com>
# 
# <https://github.com/KFERMercer/OpenWrt-CI>
#

name: OpenWrt-CI

on:
#  push:
#    branches: 
#      - main
  workflow_dispatch:

jobs:

  build_openwrt:
    name: Build OpenWrt firmware
    runs-on: ubuntu-latest
    if: github.event.repository.owner.id == github.event.sender.id

    steps:
      - name: 准备工作
        uses: actions/checkout@v3
      - name: 空间清理并部署编译环境
        env:
          DEBIAN_FRONTEND: noninteractive
        run: |
          docker rmi `docker images -q`
          sudo -E rm -rf /usr/share/dotnet /etc/mysql /etc/php /etc/apt/sources.list.d /usr/local/lib/android
          sudo -E apt-mark hold grub-efi-amd64-signed
          sudo -E apt update
          sudo -E apt -y purge azure-cli* docker* ghc* zulu* llvm* firefox google* dotnet* powershell* openjdk* mysql* php* mongodb* dotnet* moby* snap*
          sudo -E apt -y full-upgrade
          sudo -E apt -y install ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python3 python3-pip libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
          sudo -E systemctl daemon-reload
          sudo -E apt -y autoremove --purge
          sudo -E apt clean
          sudo -E timedatectl set-timezone "Asia/Shanghai"
      - name: 下载源码
        run: git clone https://github.com/coolsnowwolf/lede openwrt
      - name: 写入插件到默认配置
        run: |
          cd openwrt
          echo "src-git helloworld https://github.com/fw876/helloworld.git" >> ./feeds.conf.default
          echo "src-git package https://github.com/kjrzxu/package.git" >> ./feeds.conf.default
          echo "src-git openclash https://github.com/vernesong/OpenClash.git" >> ./feeds.conf.default
      - name: 编译5.10内核
        run: sed -i 's/PATCHVER:=5.4/PATCHVER:=5.10/' openwrt/target/linux/ramips/Makefile
      - name: 升级feeds
        run: cd openwrt && ./scripts/feeds update -a
#      - name: 替换修改luci插件和配置
#        run: chmod +x patch/diy-luci-add-rm.sh && sh patch/diy-luci-add-rm.sh
#      - name: 修改luci插件名称和顺序
#        run: chmod +x patch/diy-luci-order-name.sh && sh patch/diy-luci-order-name.sh
      - name: 安装feeds
        run: cd openwrt && ./scripts/feeds install -a
      - name: 配置config
        run: |
          cd openwrt
          cp ../.config .config
          make defconfig
      - name: 下载软件包
        run: |
          cd openwrt
          make download -j16
      - name: 编译固件
        run: |
          cd openwrt
          make -j$(nproc) || make -j1 V=s
          echo "======================="
          echo "Space usage:"
          echo "======================="
          df -h
          echo "======================="
          du -h --max-depth=1 ./ --exclude=build_dir --exclude=bin
          du -h --max-depth=1 ./build_dir
          du -h --max-depth=1 ./bin
      - name: 上传bin文件夹(固件+ipk)到 github actions
        uses: actions/upload-artifact@v3
        with:
          name: OpenWrt_firmware
          path: ./bin/
