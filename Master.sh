#/bin/bash
rm -rf /root/*
#变量
links="https://raw.githubusercontent.com/EVECloud/kws/master"
L="/home/eins"
#临时目录探测
if [ ! -d "$L" ];
then
mkdir $L;
chmod 755 $L;
fi

mkdir /usr/evekangle/
touch /usr/evekangle/lock.img

if [ ! -d "/usr/evekangle/lock.img" ];
then
echo -e "检测到之前已经执行过本脚本，出于安全考虑，已经停止脚本，如需执行请删除/usr/evekangle/lock.img文件"
else
cd $L
rm -rf $L/cfg
wget -q $links/cfg -O $L/cfg
wget -q $links/sys.sh -O $L/sys.sh
chmod 777 $L/sys.sh
clear
echo="KangleWebServer Is installing!"
echo="Please wait!"
bash $L/sys.sh
echo "861607619"
fi
