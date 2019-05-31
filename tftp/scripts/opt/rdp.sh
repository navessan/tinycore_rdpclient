#!/bin/sh

SERVER=ts01

	#magic!
	#The first expression removes XVESA= and everything before. The second one removes the next space and everything after.
	res=$(cat /proc/cmdline | sed -e 's/^.*XVESA=//' -e 's/ .*$//')
	#should be now like 1280x1024x16
	res=$(xdpyinfo |grep dimension |awk '/dimensions/{print $2}')
	
	SCR_X=$(echo $res |awk -F'[x]' '{print $1}')
	SCR_Y=$(echo $res |awk -F'[x]' '{print $2}')

PROGRAM=xfreerdp

PARAMS="/cert-ignore -sec-nla /smartcard:A /multimedia:sys:alsa /w:$SCR_X /h:$SCR_Y +fonts /d: /u: /bpp:32"
# /sound:sys:alsa,format:1,quality:high
# /w:1920 /h:1080
# /drive:home,/home/pi"

while true; do
#sleep 100
#/usb:id,dev:046d:0829
    $PROGRAM $PARAMS /v:$SERVER >> /tmp/rdp.log 2>&1

DATA=$(date +%F-%H-%M)

if eval "sudo ping -c 2 $SERVER"
        then
            echo "$DATA | TERMSRV OK"
        else
        echo "$DATA | TERMSRV no connect, testing linkup"

        ifconfig |grep "UP BROADCAST RUNNING" 

        if [ $? != 1 ]
        then
                echo "$DATA | TERMSRV no connected,run dialog">>/tmp/log-testc0nn
                dialog --title "PING ERROR" --pause "Нет связи с сервером $SERVER"  22 70 10
        else
                echo "$DATA | Linkup testing pass, cable not connected">>/tmp/log-testc0nn
                dialog --title "NO CABLE" --pause "Сетевой кабель не подключен!"  22 70 10
        fi
        clear
fi

done

