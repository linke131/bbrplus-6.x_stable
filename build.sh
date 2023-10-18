#!/bin/bash

# 复制默认配置值
make olddefconfig

# 编译内核
make -j$(nproc) binrpm-pkg
