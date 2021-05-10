#!/bin/bash
#sudo dpkg-scanpackages deb/ > Packages
#sed -i "" 's/deb\//\.\/deb\//g' Packages
update(){
cd /data/cydiarepo/DingTalkHelperX/
rm -f Packages	
rm -f Packages.gz
rm -f Packages.bz2
rm -f debs/*
cp /www/wwwroot/dcrm/Packages* .
addrs=`cat Packages|grep Filename|awk '{print $2}'`
basurl='https://repo.editornah.top:55555'
cd debs/
for addr in $addrs
do
wget $basurl$addr

done
cd ..
#tar zcvf Packages.gz Packages
#bzip2 -k Packages Packages.bz2
git add .
git commit -m '更新'
git push
}

cd /data/cydiarepo/DingTalkHelperX
md1=`md5sum Packages|awk '{print $1}'`
md2=`md5sum /www/wwwroot/dcrm/Packages|awk '{print $1}'`
echo $md1 $md2
if [ $md1 != $md2 ];then
	update
#echo "no"
fi
