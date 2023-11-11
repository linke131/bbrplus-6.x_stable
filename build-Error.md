# 关于debian And ubuntu系统内核编译囧事

各种报错❌❌❌ 各种查询相关错误解决方法均未查询到解决办法

在绞尽脑汁的情况成功编译debian第一个版本这也是第一个也是最后一个

4H8G足足编译了我 6个小时 今生不在踏入debian And ubuntu系统
除非找到各种错误解决方法且服务器配置更高的情况下会考虑再次进行编译

我之所以会决定今生不在踏入debian And ubuntu系统 
同样配置 centos alma linux 编译完成了四个版本
结果debian一个版本还没编译好 实在折腾不动了

KERNELRELEASE=6.6.0-bbrplus-bbrplus.x86_64 \
run-command KBUILD_RUN_COMMAND=+./scripts/package/builddeb
  SYNC    include/config/auto.conf.cmd
*
* Restart config...
*
*
* Certificates for signature checking
*
Provide system-wide ring of trusted keys (SYSTEM_TRUSTED_KEYRING) [Y/?] y
  Additional X.509 keys for default system keyring (SYSTEM_TRUSTED_KEYS) [] (NEW)
Error in reading or end of file.
  Reserve area for inserting a certificate without recompiling (SYSTEM_EXTRA_CERTIFICATE) [N/y/?] n
  Provide a keyring to which extra trustable keys may be added (SECONDARY_TRUSTED_KEYRING) [Y/n/?] y
Provide system-wide ring of blacklisted keys (SYSTEM_BLACKLIST_KEYRING) [Y/n/?]
y
  Hashes to be preloaded into the system blacklist keyring (SYSTEM_BLACKLIST_HASH_LIST) []
  Provide system-wide ring of revocation certificates (SYSTEM_REVOCATION_LIST) [N/y/?] n
  Allow root to add signed blacklist keys (SYSTEM_BLACKLIST_AUTH_UPDATE) [N/y/?] n
dh_listpackages: error: Package-field must be a valid package name, got: "linux-image-6.6.0-bbrplus-bbrplus.x86_64", should match "(?^:^(?^:[a-z0-9][-+\.a-z0-9]+)$)"
make[4]: *** [Makefile:2036: run-command] Error 25
make[3]: *** [debian/rules:17: binary-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
make[2]: *** [scripts/Makefile.package:146: bindeb-pkg] Error 2
make[1]: *** [/root/linux-6.6/Makefile:1538: bindeb-pkg] Error 2
make: *** [Makefile:234: __sub-make] Error 2
如上错误

或
CC [M]  kernel/kheaders.o
make[5]: *** [Makefile:1913: .] Error 2
make[4]: *** [Makefile:359: __build_one_by_one] Error 2
make[3]: *** [debian/rules:25: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
make[2]: *** [scripts/Makefile.package:146: bindeb-pkg] Error 2
make[1]: *** [/root/linux-6.6/Makefile:1538: bindeb-pkg] Error 2
make: *** [Makefile:234: __sub-make] Error 2
