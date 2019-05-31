#!/bin/sh

while true; do
#	eval $(xdotool getmouselocation --shell)
#	echo X=$X   Y=$Y

	#magic!
	#The first expression removes XVESA= and everything before. The second one removes the next space and everything after.
	res=$(cat /proc/cmdline | sed -e 's/^.*XVESA=//' -e 's/ .*$//')
	#should be now like 1280x1024x16
	res=$(xdpyinfo |grep dimension |awk '/dimensions/{print $2}')
	
	SCR_X=$(echo $res |awk -F'[x]' '{print $1}')
	SCR_Y=$(echo $res |awk -F'[x]' '{print $2}')
	
	X=$(xdotool getmouselocation| awk -F'[: ]' '{print $2}')
	Y=$(xdotool getmouselocation| awk -F'[: ]' '{print $4}')

	dx=$(( $SCR_X - $X))
	dy=$(( $SCR_Y - $Y))
	echo screen $SCR_X x $SCR_Y mouse: $X $Y diff $dx $dy

    if [ $dx -lt 10 ] && [ $dy -lt 10 ]
    then
        echo rrrr
        conky -c /opt/conkyrc &
        P=$!
        echo $P
        sleep 10
        kill $P
    else
        sleep 1
    fi
done
