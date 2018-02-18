#!/bin/bash
source /home/eins/cfg
#变量
#main
#yum与epel配置
yum install wget -y #安装wget，防止用curl导致错误
yum install yum-fastestmirror -y #自动寻找最快的mirrors
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak #备份yum源
rpm -e epel-release #卸载旧epel（如果有，以后可改为自动判断）
wget -O /etc/yum.repos.d/CentOS-Base.repo $yumo #下载aliyun yum源
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo #下载aliyun epel源
yum clean all #清除所有缓存
yum makecache #生成缓存
echo "timeout=120" >> /etc/yum.conf #防止自动退出
#yum -y update #更新
yum -y install which file make automake gcc gcc-c++ pcre-devel zlib-devel openssl-devel sqlite-devel quota unzip bzip2 libaio-devel
ulimit -n 1048576 #设置内核可以同时打开的文件描述符的最大值，防止编译失败
#更改linux令人窒息的默认设置
echo "* soft nofile 1048576" >> /etc/security/limits.conf #设置用户单进程的最大文件数，避免得到大量使用完文件句柄的错误信息 默认为1024
echo "* hard nofile 1048576" >> /etc/security/limits.conf #同上 
echo "6553560" >> /proc/sys/fs/file-max 
echo "fs.file-max = 6553560" >> /etc/sysctl.conf

#Install Start!!
cd /home/eins/
wget $ins/ins.sh
chmod 777 ins.sh
bash ins.sh
