#/bin/bash
# Author :EwigeveMicca
# Blog ：www.evec.cc
#转载，二开请注明版权谢谢
#版权意识=个人素质
L="/home/eins"

trap exit SIGTSTP

function lock(){
mkdir /usr/evekangle/
touch /usr/evekangle/lock.img
echo "The script has been executed before the detection is detected. For security considerations, the script has been stopped, and if you need to execute, please delete the /usr/evekangle/lock.img file" >> /usr/evekangle/lock.img
}

function system(){
setenforce 0 && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
echo "timeout=120" >> /etc/yum.conf #防止自动退出
#yum install wget -y #安装wget
yum clean all #清除所有缓存
yum makecache #生成缓存
yum  install epel-release -y
rm -rf /etc/yum.repos.d/CentOS-Base.repo
wget https://raw.githubusercontent.com/duww-top/mirrors/master/CentOS/CentOS6-Base-itzmx.repo -O /etc/yum.repos.d/CentOS6-Base-itzmx.repo
rm -rf /etc/yum.repos.d/*pel.repo
rm -rf /etc/yum.repos.d/epel-testing.repo
wget https://raw.githubusercontent.com/duww-top/mirrors/master/EPEL/epel.repo -O /etc/yum.repos.d/epel.repo
wget https://raw.githubusercontent.com/duww-top/mirrors/master/EPEL/epel-testing.repo -O /etc/yum.repos.d/epel-testing.repo
rpm -ivh https://raw.githubusercontent.com/duww-top/repo/master/CentOS/mysql-community-release-el6-5.noarch.rpm
rm -rf /etc/yum.repos.d/mysql-community.repo
rm -rf /etc/yum.repos.d/mysql-community-source.repo
wget https://raw.githubusercontent.com/duww-top/repo/master/CentOS/mysql-community.repo -O /etc/yum.repos.d/mysql-community.repo
wget https://raw.githubusercontent.com/duww-top/repo/master/CentOS/mysql-community-source.repo -O /etc/yum.repos.d/mysql-community-source.repo
#yum -y update #更新
yum -y install which file make automake gcc gcc-c++ pcre-devel zlib-devel openssl-devel sqlite-devel quota unzip bzip2 libaio-devel
ulimit -n 1048576 #设置内核可以同时打开的文件描述符的最大值
#更改linux令人窒息的默认设置
 echo "* soft nofile 1048576" >> /etc/security/limits.conf #设置用户单进程的最大文件数，避免得到大量使用完文件句柄的错误信息 默认为1024
 echo "* hard nofile 1048576" >> /etc/security/limits.conf #同上 
 echo "6553560" >> /proc/sys/fs/file-max 
 echo "fs.file-max = 6553560" >> /etc/sysctl.conf
iptables -A INPUT -p tcp --dport 3306 -j DROP #禁止外网连接MySQL数据库
}

function install(){
cd $L
 wget https://raw.githubusercontent.com/duww-top/kangle/master/ent/e.sh -O e.sh;sh e.sh /vhs/kangle
 wget https://raw.githubusercontent.com/duww-top/kangle/master/kangle/easypanel/ep.sh -O ep.sh;sh ep.sh
#优化php5.2参数
rm -rf /vhs/kangle/ext/tpl_php52/php-templete.ini
 wget https://raw.githubusercontent.com/duww-top/githubkangle/master/php-templete.ini -O /vhs/kangle/ext/tpl_php52/php-templete.ini
rm -rf /vhs/kangle/ext/tpl_php52/etc/php-node.ini
 wget https://raw.githubusercontent.com/duww-top/githubkangle/master/php-node.ini -O /vhs/kangle/ext/tpl_php52/etc/php-node.ini
#编译安装libevent
 wget https://raw.githubusercontent.com/duww-top/transmission/master/2.84/libevent-2.0.21-stable.tar.gz
tar zxf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make -s -j 4
make -s install
ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib/libevent-2.0.so.5
ln -s /usr/local/lib/libevent-2.0.so.5.1.9 /usr/lib/libevent-2.0.so.5.1.9
ln -s /usr/lib/libevent-2.0.so.5 /usr/local/lib/libevent-2.0.so.5
ln -s /usr/lib/libevent-2.0.so.5.1.9 /usr/local/lib/libevent-2.0.so.5.1.9
cd $L
#安装memcache
yum -y install memcached php-pecl-memcache
yum -y install php-pecl-apc
rm -rf /etc/sysconfig/memcached
 wget https://raw.githubusercontent.com/duww-top/kangle/master/memcached/memcached -O /etc/sysconfig/memcached
service memcached start
chkconfig --level 2345 memcached on
#优化mysql
yum -y install mysql mysql-server
rm -rf /etc/my.cnf
 wget https://raw.githubusercontent.com/duww-top/githubkangle/master/my.cnf -O /etc/my.cnf 
service mysqld restart
#安装各版本php
cd $L
yum -y install bzip2-devel libxml2-devel curl-devel db4-devel libjpeg-devel libpng-devel freetype-devel pcre-devel zlib-devel sqlite-devel libmcrypt-devel unzip bzip2
yum -y install mhash-devel openssl-devel
yum -y install libtool-ltdl libtool-ltdl-devel
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/5.2/5217/completed/tpl_php5217.tar.gz -O tpl_php5217.tar.gz
tar xzf tpl_php5217.tar.gz
mv tpl_php5217 /vhs/kangle/ext
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/5.4/5445/completed/tpl_php5445.tar.gz -O tpl_php5445.tar.gz
tar xzf tpl_php5445.tar.gz
mv tpl_php5445 /vhs/kangle/ext
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/5.5/5538/completed/tpl_php5538.tar.gz -O tpl_php5538.tar.gz
tar xzf tpl_php5538.tar.gz
mv tpl_php5538 /vhs/kangle/ext
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/7.0/7027/completed/tpl_php7027.tar.gz -O tpl_php7027.tar.gz
tar xzf tpl_php7027.tar.gz
mv tpl_php7027 /vhs/kangle/ext
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/7.1/7113/completed/tpl_php7113.tar.gz -O tpl_php7113.tar.gz
tar xzf tpl_php7113.tar.gz
mv tpl_php7113 /vhs/kangle/ext
#
 wget -c https://raw.githubusercontent.com/duww-top/kangle/master/php/7.2/721/completed/tpl_php721.tar.gz -O tpl_php721.tar.gz
tar xzf tpl_php721.tar.gz
mv tpl_php721 /vhs/kangle/ext
rm -rf /tmp/*
/vhs/kangle/bin/kangle -r

#ks ms守护进程
#if [ ! -d "/etc/crontab" ];
#then
#yum -y install vixie-cron
#yum -y install crontabs
#service crond start
#chkconfig --level 345 crond on
#echo "*/1 * * * * root /vhs/kangle/bin/kangle" >> /etc/crontab
#echo "*/1 * * * * root /etc/init.d/mysqld start" >> /etc/crontab
#/etc/init.d/crond restart
#fi
#echo "*/1 * * * * root /vhs/kangle/bin/kangle" >> /etc/crontab
#echo "*/1 * * * * root /etc/init.d/mysqld start" >> /etc/crontab
#/etc/init.d/crond restart
#
yum -y install vixie-cron
yum -y install crontabs
service crond start
chkconfig --level 345 crond on
echo -e "*/1 * * * * root /etc/init.d/mysqld start" >> /etc/crontab
echo -e "*/1 * * * * root /vhs/kangle/bin/kangle" >> /etc/crontab
/etc/init.d/crond restart
#
rm -rf /vhs/kangle/www/index.html
wget https://raw.githubusercontent.com/duww-top/githubkangle/master/404.html -O /vhs/kangle/www/index.html
#
#mv /vhs/kangle/nodewww/webftp/admin/control/system.ctl.php /home/system.ctl.php
#
#cd /home/eins/
#wget http://origin.evec.cc/github/kangle/default.tar.gz
#tar -xzvf default.tar.gz
#rm -rf /home/eins/default.tar.gz
#rm -rf /vhs/kangle/nodewww/webftp/vhost/view/default
#mv /home/eins/default /vhs/kangle/nodewww/webftp/vhost/view/default
rm -rf /home/eins
rm -rf /vhs/kangle/nodewww/webftp/vhost/view/default/kfinfo.html
wget https://raw.githubusercontent.com/duww-top/githubkangle/master/kfinfo.html -O /vhs/kangle/nodewww/webftp/vhost/view/default/kfinfo.html
rm -rf /vhs/kangle/etc/config.xml
wget https://raw.githubusercontent.com/duww-top/githubkangle/master/config.xml -O /vhs/kangle/etc/config.xml
/vhs/kangle/bin/kangle -r
clear
echo -e "\033[4;31m KangleWebServer has been installed successfully \033[0m"
}

function checkroot(){
# Check If You Are Root
if [ $(id -u) != "0" ]; then
    clear
    echo -e "\033[31mYou must use root permissions! \033[0m"
    exit 1
fi
}

function check_arch() {
	architecture=$(uname -m)
	case $architecture in
		amd64|x86_64)
			;;
		*)
		clear
			cat 1>&2 <<-EOF
			Please use the Centos 6 64bit,your system architecture is: $architecture
			EOF
			exit 1
			;;
	esac
}

function install_start (){

checkroot

check_arch

if [ $(arch) == i686 ]; then
    clear
    echo -e "\033[31mPlease use the Centos 6 64bit \033[0m"
    exit 1
elif [ $(arch) == i386 ]; then
    clear
    echo -e "\033[31mPlease use the Centos 6 64bit \033[0m"
    exit 1
elif [ $(arch) == x86_64 ]; then

if [ ! -f "/usr/evekangle/lock.img" ]; #check锁
then
if [ ! -d "$L" ];then
mkdir $L;
chmod 755 $L;
fi

system
install

else
clear
echo -e "\033[4;31mThe script has been executed before the detection is detected. For security considerations, the script has been stopped, and if you need to execute, please delete the /usr/evekangle/lock.img file \033[0m"
exit
fi

lock #锁
fi

}

#######################################################################

#Start！

rm -rf $0
install_start

#######################################################################
