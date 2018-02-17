#/bin/bash
#变量
links="https://raw.githubusercontent.com/EVECloud/kws/master"
L="/home/eins"
#临时目录探测
if [ ! -d "$L" ];
then
mkdir $L;
chmod 755 $L;
fi

cd $L
rm -rf $L/cfg
wget -q $links/cfg -O $L/cfg
wget -q $links/sys.sh -O $L/sys.sh
chmod 777 $L/sys.sh
clear
echo="KangleWebServer Is installing!"
echo="Please wait!"
bash $L/sys.sh
