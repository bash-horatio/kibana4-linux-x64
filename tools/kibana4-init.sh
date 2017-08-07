#!/bin/bash

Name="kibana4"
Dir=`dirname $0`
Script=`basename $0`
Index=".$Name"

Port="5601"
Sysv="$Dir/${Name}-sysv.sh"

if [ $# -eq 1 ]; then
    ESUrl="http://$1:9200"
    echo "ES URL is $ESUrl"
else
    ESUrl="http://localhost:9200"
fi


if [ -x "/usr/sbin/service" ]; then
    sudo service $Name stop
elif [ -x "/usr/sbin/systemctl" ]; then
    sudo systemctl stop $Name
else
    echo -e "$Script:\033[31m Only Sysv and Systemd supported\033[0m"
    exit 1
fi


curl -XDELETE "$ESUrl/$Index?pretty"
$Dir/elasticdump --input=$Dir/kmap.json  --output=$ESUrl/$Index --type=mapping
$Dir/elasticdump --input=$Dir/kdata.json --output=$ESUrl/$Index --type=data


sudo chmod +x $Sysv
sudo cp $Sysv /etc/init.d/$Name

if [ -x "/usr/sbin/update-rc.d" ]; then
    sudo update-rc.d kibana4 defaults 96 9
elif [ -x "/usr/sbin/chkconfig" ]; then
    sudo chkconfig --add $Name
    sudo chkconfig --level 2345 $Name on
else
    echo -e "$Script:\033[31m Only update-rc.d and chkconfig supported\033[0m"
    exit 1
fi
echo -e "$Script: Now, $Name can be manipulated by\033[31m systemctl OR service\033[0m easily!"

if [ -x "/usr/sbin/service" ]; then
    sudo service $Name start
elif [ -x "/usr/sbin/systemctl" ]; then
    sudo systemctl start $Name
fi
echo -e "$Script: Look\033[31m /var/log/$Name/$Name.log\033[0m for more information"


echo -e "$Script: \033[31m wait 1 minutes for kibana4 optimizing runtime data\033[0m"
sleep 1m
echo -e "$Script: Finished! Now open\033[31m $HOSTNAME:$Port\033[0m in browser, please"
