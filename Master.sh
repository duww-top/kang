#/bin/bash
rm -rf /root/*
#
function lock(){
mkdir /usr/evekangle/
touch /usr/evekangle/lock.img
}
#
links="https://raw.githubusercontent.com/EVECloud/kws/master"
L="/home/eins"
#临时目录探测
if [ ! -d "$L" ];
then
mkdir $L;
chmod 755 $L;
fi

if [ ! -f "/usr/evekangle/lock.img" ];
then
cd $L
rm -rf $L/cfg
wget -q $links/cfg -O $L/cfg
wget -q $links/sys.sh -O $L/sys.sh
chmod 777 $L/sys.sh
clear
echo="KangleWebServer Is installing!"
echo="Please wait!"
sleep 3
bash $L/sys.sh
echo "861607619"
else
clear
echo -e "\033[4;31m The script has been executed before the detection is detected. For security considerations, the script has been stopped, and if you need to execute, please delete the /usr/evekangle/lock.img file \033[0m"
echo "861607619"
exit
fi

lock
