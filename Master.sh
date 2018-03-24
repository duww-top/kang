#/bin/bash
rm -rf /root/* #清理环境
####锁####
function lock(){
mkdir /usr/evekangle/
touch /usr/evekangle/lock.img
}
####锁####
links="https://raw.githubusercontent.com/EVECloud/kws/master"
L="/home/eins"
#安装临时目录探测
if [ ! -d "$L" ];
then
mkdir $L;
chmod 755 $L;
fi

if [ ! -f "/usr/evekangle/lock.img" ]; #验证锁文件
then
####开始接受数据文件####
cd $L
rm -rf $L/cfg
wget -q $links/cfg -O $L/cfg
####数据文件接收完毕####

####启动安装####
wget -q $links/sys.sh -O $L/sys.sh
chmod 777 $L/sys.sh
bash $L/sys.sh #开始运行安装程序
####安装结束####
else
clear
echo -e "\033[4;31m The script has been executed before the detection is detected. For security considerations, the script has been stopped, and if you need to execute, please delete the /usr/evekangle/lock.img file \033[0m"
exit
fi

lock #程序安全机制加锁
