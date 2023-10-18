# bbrplus-6.x_stable
Linux BBRplus Kernel 6.x Stable（非LTS）

从BBRplus 4.14移植 （注意它并不基于6.x版本的BBR，而只是简单移植了4.14版本的BBRplus）

<br/>
<br/>
<br/>

***基于原始版本***  
https://github.com/cx9208/bbrplus 
  
<br/>
<br/> 

## 截至 2023 年 8 月 进行了一些改进

###  i) 将 2018-2023 年间的官方 tcp_bbr 补丁合并到 bbrplus 中  
###  ii) 保留官方 tcp_bbr 模块，因此可以使用其中之一  
```sh
net.ipv4.tcp_congestion_control = bbrplus
net.core.default_qdisc = fq
```
或
```sh
net.ipv4.tcp_congestion_control = bbr
net.core.default_qdisc = fq
```
在文件中/etc/sysctl.conf. &nbsp;&nbsp; ( fq是唯一推荐的数据包调度程序 请勿使用fq_codel fq_pie cake等 ) 
<br/>
<br/>
<br/>

## 自己修补并构建 bbrplus 内核
(或者你可以使用我在“Releases”部分编译的版本)   
<br/>
***(GCC的构建要求> = 4.9, 因此如果使用CentOS 7.x作为构建器, 则需要GCC升级)*** 
<br/>

### 1) 在此存储库上获取转换补丁, 使用git或直接下载
```
(e.g., convert_official_linux-6.4.x_src_to_bbrplus.patch)
```

<br/>
<br/>

### 2) 下载官方linux内核, 6.5.7可自定义为你想下载的版本
```
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.7.tar.xz
```

<br/>
<br/>

### 3) 解压 tarball & cd 解压目录
```
tar xvf linux-6.5.7.tar.xz && cd linux-6.5.7
```

<br/>
<br/>

### 4) 将转换补丁复制到解压后的内核目录
```
something like
```

```
cp ../convert_official_linux-6.4.x_src_to_bbrplus.patch .
```

<br/>
<br/>

### 5) 进行补丁工作
```
patch -p1 < convert_official_linux-6.5.x_src_to_bbrplus.patch
```
或
```
patch -p1 < ../convert_official_linux-6.5.x_src_to_bbrplus.patch
```

<br/>
<br/>

(如果上一步没有错误或失败)
### 6) 安装构建内核的依赖项

<br/>

***CentOS***  
sudo yum groupinstall -y "Development Tools"  
sudo yum -y install ncurses-devel bc gcc gcc-c++ ncurses ncurses-devel cmake elfutils-libelf-devel openssl-devel rpm-build redhat-rpm-config asciidoc hmaccalc perl-ExtUtils-Embed xmlto audit-libs-devel binutils-devel elfutils-devel elfutils-libelf-devel newt-devel python-devel zlib-devel

<br/>

***CentOS Stream 9所需编译依赖***

yum inatall -y make gcc ncurses-devel flex bison openssl-devel bc elfutils-libelf-devel perl dwarves

<br/>

***Debian/Ubuntu***  
sudo apt install -y build-essential libncurses5-dev  
sudo apt build-dep linux

<br/>
<br/>

### 7) 根据当前内核设置配置构建参数
        make oldconfig

<br/>

***(注意：如果使用带有 Xen 虚拟化的 CentOS 7.x，则必须设置 CONFIG_XEN_BLKDEV_FRONTEND=y，否则虚拟机将无法启动.)***

<br/>

当询问时按 Enter 键（如果不知道是什么）


<br/>
<br/>

### 8) 禁用调试信息和模块签名
        scripts/config --disable SECURITY_LOCKDOWN_LSM
        scripts/config --disable DEBUG_INFO
        scripts/config --disable MODULE_SIG


<br/>
<br/>

### 9) 构建 kernel

<br/>

***CentOS***   
make rpm-pkg LOCALVERSION=-bbrplus 2>&1 | tee build.log

<br/>

***Debian/Ubuntu***  
make deb-pkg LOCALVERSION=-bbrplus 2>&1 | tee build.log

<br/>

如果出现任何问题, 请检查“build.log”文件

<br/>
<br/>

(如果上一步没有失败)
### 10) 收集内核包文件, 在其他Linux机器上进行测试

<br/>

***CentOS 文件***   
located in  
/"user home dir"/rpmbuild/RPMS/x86_64/

<br/>

***Debian/Ubuntu 文件***  
located in  
parent directory  




