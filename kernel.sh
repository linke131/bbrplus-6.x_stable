#!/bin/bash
# by Linke 2023 临客
#-----可变参数-start-----
# 要编译的kernel版本
# kernel的大版本号
kernel_version=6.5
# 的具体版本号
version=$kernel_version.7

#-----可变参数-end-----
 
echo -e "\033[31m\033[01m[ $1即将编译kernel$version ]\033[0m"
 
# 安装依赖以及升级索引

# 安装 dnf
{
echo -e '开始安装dnf安装包管理工具'
yum install dnf -y
echo -e 'dnf管理工具安装完成'
}

# 更新系统
{
echo -e '开始更新系统'
dnf update -y
echo -e "\033[31m\033[01m[ $1系统更新完成]\033[0m"
}

# 安装依赖
{
dnf install -y ncurses-devel gcc-c++ make openssl-devel bison flex elfutils-libelf-devel rsync bc git wget patch rpm-build
}

# 下载kernel
{
echo -e '正在下载kernel'
# 使用官方网址下载--速度可能比较慢 1
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$version.tar.xz

echo -e "正在解压"
# 静默解压
tar xvf linux-6.5.7.tar.xz && rm -rf linux-6.5.7.tar.xz
# 删除压缩包
echo -e "\033[31m\033[01m[ $1解压完成, 删除压缩包]\033[0m"

# git获取补丁
git clone https://github.com/linke131/bbrplus-6.x_stable.git

# 复制补丁
cp /root/bbrplus-6.x_stable/convert_official_linux-6.5.x_src_to_bbrplus.patch /root/linux-6.5.7

# 删除文件
rm -rf bbrplus-6.x_stable

# 进入内核目录
cd linux-6.5.7

# 运行补丁
patch -p1 < convert_official_linux-6.5.x_src_to_bbrplus.patch

# 删除补丁
rm -rf convert_official_linux-6.5.x_src_to_bbrplus.patch

# 复制当前内核配置
make oldconfig

# 打开配置菜单
#make menuconfig

# 编译提示
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此编译安装时间较长 4H8G 编译平均1-1.5个小时完成编译安装 如时间不充足需临时取消编译可Ctrl+C取消安装]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快 重要的事情说三遍]\033[0m"

sleep 10

# 禁用调试信息和模块签名
scripts/config --disable SECURITY_LOCKDOWN_LSM
scripts/config --disable DEBUG_INFO
scripts/config --disable MODULE_SIG

# 编译内核
echo -e "\033[31m\033[01m[ $1正在编译内核]\033[0m"
make -j$(nproc) binrpm-pkg LOCALVERSION=-bbrplus 2>&1 | tee build.log
}

# kernel-6.5.7安装完成
{
echo -e "kernel-${version}编译已完成"
}

# 额外功能安装内核并启用内核
#yum install -y kernel-6.5.7_bbrplus-*.rpm
#grub2-set-default "kernel-6.5.7_bbrplus-1.x86_64"
#grub2-mkconfig -o /boot/grub2/grub.cfg

# 重启系统
#{
#read -p "需重启系统才能使环境变量生效，是否现在重启 ? [Y/n] :" yn
#  [ -z "${yn}" ] && yn="y"
#  if [[ $yn == [Yy] ]]; then
#    echo -e "${Info} VPS 重启中..."
#    reboot
#  fi
#}

