#!/bin/bash
wget -P $L/config http://origin.evec.cc/github/kangle/config
source $L/config
#变量

#环境检测
cos5="CentOS release 5"
cos6="CentOS release 6"
OS5=`cat /etc/redhat-release |grep "$cos5" -o` #读取系统版本
OS6=`cat /etc/redhat-release |grep "$cos6" -o` #读取系统版本
case $OS5 in
   $cos5) P5="\033[32m5\033[0m";; #完全符合
   *) P5="\033[30m5\033[0m";; #特征符合
esac
case $OS6 in
   $cos6) P6="\033[32m6\033[0m";; #完全符合
   *) P6="\033[30m6\033[0m";;  #特征符合
esac
if [ "$cos5" = "$OS5" ] | [ "$OS6" = "$cos6" ]; #校对系统版本
then
clear #清屏

#main
#yum与epel配置
yum install wget -y #安装wget，防止用curl导致错误
yum install yum-fastestmirror -y #自动寻找最快的mirrors
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak #备份yum源
rpm -e epel-release #卸载旧epel（如果有，以后可改为自动判断）
wget -P /etc/yum.repos.d/CentOS6-Base.repo $yumo #下载aliyun yum源
wget -P /etc/yum.repos.d/ $epel #下载aliyun epel源
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
cd /$L
mv ins.sh ins.sh.ebak
wget $L/ins.sh
chmod 777 ins.sh
bash ins.sh








