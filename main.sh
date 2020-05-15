#!/bin/sh
function install() {
	centos=`cat /etc/redhat-release`
    XT=`cat /etc/redhat-release | awk '{print $3}'| cut -b1`
	CPU=$(grep 'model name' /proc/cpuinfo |uniq |awk -F : '{print $2}' |sed 's/^[ \t]*//g' |sed 's/ \+/ /g') 
	H=`cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l`
	HX=`cat /proc/cpuinfo | grep "core id" |wc -l`
	DD=`df -h /`
    W=`getconf LONG_BIT`
	G=`awk '/MemTotal/{printf("%1.1fG\n",$2/1024/1024)}' /proc/meminfo`

echo -e "\033[1;33m===================================服务器配置===================================\033[0m"
echo -e "\033[1;32m                 系统版本：$centos   $W 位 \033[0m"
echo -e "\033[1;32m                 CPU 型号：${CPU} \033[0m"
echo -e "\033[1;32m                 CPU核心：$HX核  \033[0m"
echo -e "\033[1;32m                 运行内存：$G     \033[0m"
echo -e "\033[1;33m==================================硬盘使用情况==================================\033[0m"
echo -e "\033[1;32m$DD\033[0m"
echo -e "\033[1;33m================================================================================\033[0m"
echo -e "\033[32m  \033[0m"
echo -e "————————————————————————————————————————————————————
	\033[1mDUWW Kangle 一键脚本\033[0m
	\033[32mKangle一键脚本-主菜单\033[0m
	说明：kanglesh命令可随时打开当前菜单
	回车继续安装
————————————————————————————————————————————————————" 
	read
	service0
}

function service0() {
echo -e "\033[1;33m================================================================================\033[0m"
echo -e "\033[1;36m                 1.Kangle+Easypanel+MySQL5.6+PHP\033[0m"
echo -e "\033[1;36m                 PHP包括：PHP5.2，PHP5.3，PHP5.4，PHP5.5，PHP7.0，PHP7.1，PHP7.2\033[0m"
echo -e "\033[1;36m                 Kangle默认为商业版，解锁全部功能\033[0m"
echo -e "\033[1;36m                 2.更改MySQL密码\033[0m"
echo -e "\033[1;36m                 3.开启前台用户泛解析\033[0m"
echo -e "\033[1;36m                 4.关闭前台用户泛解析\033[0m"
echo -e "\033[1;36m                 5.打开MySQL外网访问\033[0m"
echo -e "\033[1;36m                 6.关闭MySQL外网访问\033[0m"
echo -e "\033[1;36m                 7.修复EP软连接漏洞\033[0m"
echo -e "\033[1;36m                 8.清理垃圾文件释放空间\033[0m"
echo -e "\033[1;36m                 9.重置Kangle后台登录密码\033[0m"
echo -e "\033[1;36m                 10.修复系统DNS\033[0m"
echo -e "\033[1;36m                 s.更新脚本\033[0m"
echo -e "\033[1;36m                 0.退出安装\033[0m"
echo -e "\033[1;33m================================================================================\033[0m"  
	read -p "输入选项: " number
	NUMBER=$number
	if [ "$NUMBER" = "1" ] ; then
		service1
	elif [ "$NUMBER" = "2" ] ; then
		service2
	elif [ "$NUMBER" = "3" ] ; then
		service3
	elif [ "$NUMBER" = "4" ] ; then
		service4
	elif [ "$NUMBER" = "5" ] ; then
		service5
	elif [ "$NUMBER" = "6" ] ; then
		service6
	elif [ "$NUMBER" = "7" ] ; then
		service7
	elif [ "$NUMBER" = "8" ] ; then
		service8
	elif [ "$NUMBER" = "9" ] ; then
		service9
	elif [ "$NUMBER" = "10" ] ; then
		service10
	elif [ "$NUMBER" = "s" ] ; then
		services
    else
        exit 0
    fi
}
	
function service1() {
        echo -e "\033[1;31m准备安装Kangle+Easypanel+MySQL5.6+PHP！\033[0m"
		rm -rf $0
        yum install wget -y
        #2018/5/27 修正
        cd /root
        echo -e "\033[1;31m开始安装Kangle+Easypanel+MySQL5.6+PHP！\033[0m"
        bash -c "$(curl -sS https://raw.githubusercontent.com/duww-top/kang/master/Install.sh)"
}

function service2() {
        echo -e "\033[1;31m准备更改MySQL密码！\033[0m"
		bash -c "$(curl -sS https://raw.githubusercontent.com/duww-top/githubkangle/master/revise.sh)"
}

function service3() {
        echo -e "\033[1;31m开启前台用户泛解析！\033[0m"
		wget https://raw.githubusercontent.com/duww-top/EPDomainChange/master/change.sh
		chmod 777 change.sh
		./change.sh Open
		rm -rf change.sh
        echo -e "\033[1;31m开启前台用户泛解析成功！\033[0m"
}

function service4() {
        echo -e "\033[1;31m关闭前台用户泛解析！\033[0m"
		wget https://raw.githubusercontent.com/duww-top/EPDomainChange/master/change.sh
		chmod 777 change.sh
		./change.sh Close
		rm -rf change.sh
        echo -e "\033[1;31m关闭前台用户泛解析成功！\033[0m"
}

function service5() {
    echo -e "\033[1;31m打开3306外网访问！\033[0m"
	iptables -A INPUT -p tcp --dport 3306 -j ACCEPT #打开3306外网访问
    echo -e "\033[1;31m打开3306外网访问成功！\033[0m"
}

function service6() {
    echo -e "\033[1;31m关闭3306外网访问！\033[0m"
	iptables -A INPUT -p tcp --dport 3306 -j DROP
	echo -e "\033[1;31m关闭3306外网访问成功！\033[0m"
}

function service7() {
    echo -e "\033[1;31m修复EP软连接漏洞开始安装！\033[0m"
	bash -c "$(curl -sS http://origin.evec.cc/github/kangle/fixsoftlink.sh)"
	echo -e "\033[1;31m修复EP软连接漏洞成功！\033[0m"
}

function service8(){
	echo "正在执行清理垃圾任务，执行时间由文件数量决定，请耐心等待。。。"
	rm -rf /vhs/kangle/tmp/*
	rm -rf /vhs/kangle/var/*.log
	rm -rf /tmp
	mkdir /tmp
	chmod -R 777 /tmp
	/vhs/kangle/bin/kangle --reboot

	echo "清理垃圾文件释放空间执行完毕！"
}

function service9(){
	clear
	read -p "请输入Kangle管理员-新用户名：" ep_admin
	echo -e "\033[44;37m 你输入Kangle管理员-新用户名是：$ep_admin \033[0m"
	read -p "请输入Kangle管理员-新密码：" ep_passwd
	echo -e "\033[44;37m 你输入Kangle管理员-新密码是：$ep_passwd \033[0m"
	# passwdmd5=` echo -n '$ep_passwd'|md5sum|cut -d ' ' -f1 `
	nl /vhs/kangle/etc/config.xml | sed -i "s/admin user='.*' password='.*' a/admin user='$ep_admin' password='$ep_passwd' a/g" /vhs/kangle/etc/config.xml
	service kangle restart
	echo "Kangle管理员账户&密码已修改成功"
}

function service10(){
	echo -e "———————————————————————————
	\033[32m修复系统DNS\033[0m
	1. 114DNS（国内服务器）
	2. 谷歌DNS（国外服务器）"
	read -p "请输入序号并回车:" YORN
	if [ "$YORN" = "2" ]; then
		echo -e "options timeout:1 attempts:1 rotate\nnameserver 8.8.8.8\nnameserver 8.8.4.4" >/etc/resolv.conf;
		echo "已经成功更改为谷歌DNS"
	else
		echo -e "options timeout:1 attempts:1 rotate\nnameserver 114.114.114.114\nnameserver 114.114.115.115" >/etc/resolv.conf;
		echo "已经成功更改为114DNS"
	fi
}

function services(){
	wget https://raw.githubusercontent.com/duww-top/kang/master/main.sh
	cp -f main.sh /usr/bin/kanglesh
	chmod 777 /usr/bin/kanglesh
	sh main.sh
}

install

echo -e "\033[1;31m################################################################################\033[0m" 
echo -e "\033[1;31m###                                                                          ###\033[0m"
echo -e "\033[1;31m###                              感谢使用本脚本                              ###\033[0m"
echo -e "\033[1;31m###                            杜雯雯播放器：duww.top                        ###\033[0m"
echo -e "\033[1;31m###                              作者：26974566                              ###\033[0m"
echo -e "\033[1;31m###                                                                          ###\033[0m"
echo -e "\033[1;31m################################################################################\033[0m" 

cd
