#!/bin/bash
source /home/eins/cfg
###########################################################################3
#开始调用小樱script
wget $kangleins -O e.sh;sh e.sh /vhs/kangle #安装Kangle
wget $epins -O ep.sh;sh ep.sh #安装easypanle
#优化php5.2参数
rm -rf /vhs/kangle/ext/tpl_php52/php-templete.ini
wget $phpcfg -O /vhs/kangle/ext/tpl_php52/php-templete.ini
rm -rf /vhs/kangle/ext/tpl_php52/etc/php-node.ini
wget $phpnode -O /vhs/kangle/ext/tpl_php52/etc/php-node.ini
#编译安装libevent
wget $libevent
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
wget $memcached -O /etc/sysconfig/memcached
service memcached start
chkconfig --level 2345 memcached on
#优化mysql
yum -y install mysql mysql-server
rm -rf /etc/my.cnf
wget $mysqlconig -O $L/MY.cnf
mv my.cnf /etc/my.cnf
service mysqld restart
#安装各版本php
yum -y install bzip2-devel libxml2-devel curl-devel db4-devel libjpeg-devel libpng-devel freetype-devel pcre-devel zlib-devel sqlite-devel libmcrypt-devel unzip bzip2
yum -y install mhash-devel openssl-devel
yum -y install libtool-ltdl libtool-ltdl-devel
#
wget -c $phpurl/tpl_php5217.tar.gz -O tpl_php5217.tar.gz
tar xzf tpl_php5217.tar.gz
mv tpl_php5217 /vhs/kangle/ext
#
wget -c $phpurl/tpl_php5445.tar.gz -O tpl_php5445.tar.gz
tar xzf tpl_php5445.tar.gz
mv tpl_php5445 /vhs/kangle/ext
#
wget -c $phpurl/tpl_php5538.tar.gz -O tpl_php5538.tar.gz
tar xzf tpl_php5538.tar.gz
mv tpl_php5538 /vhs/kangle/ext
#
wget -c $phpurl/tpl_php7027.tar.gz -O tpl_php7027.tar.gz
tar xzf tpl_php7027.tar.gz
mv tpl_php7027 /vhs/kangle/ext
#
wget -c $phpurl/tpl_php7113.tar.gz -O tpl_php7113.tar.gz
tar xzf tpl_php7113.tar.gz
mv tpl_php7113 /vhs/kangle/ext
#
wget -c $phpurl/tpl_php721.tar.gz -O tpl_php721.tar.gz
tar xzf tpl_php721.tar.gz
mv tpl_php721 /vhs/kangle/ext
rm -rf /tmp/*
/vhs/kangle/bin/kangle -r
###########################################################################
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
echo -e "* */23 * * * root curl https://www.evec.cc" >> /etc/crontab
/etc/init.d/crond restart
#
rm -rf /vhs/kangle/www/index.html
wget http://origin.yunsh.org/kangle/index.html -O /vhs/kangle/www/index.html
#
#mv /vhs/kangle/nodewww/webftp/admin/control/system.ctl.php /home/system.ctl.php
#
wget http://origin.evec.cc/github/kangle/default.zip
unzip default.zip
rm -rf /root/default.zip
rm -rf /vhs/kangle/nodewww/webftp/vhost/view/default
mv /root/default /vhs/kangle/nodewww/webftp/vhost/view/default
rm -rf /home/eins
rm -rf /root/*
clear
