#!/bin/sh

SRC=http://192.168.3.100/tftpboot/linux/tinycore/scripts/opt

DST=/opt

files='conkyrc mouse.sh rdp.sh kiosk.sh'

for F in $files
do
	wget $SRC/$F -O $DST/$F
	chmod +x $DST/$F
done

USER="tc"

wget $SRC/xsession -O /home/$USER/.xsession
chown "$USER" /home/$USER/.xsession

#magic!
#The first expression removes XVESA= and everything before. The second one removes the next space and everything after.
XVESA=$(cat /proc/cmdline | sed -e 's/^.*XVESA=//' -e 's/ .*$//')
	
#should be now like 1280x1024x16

[ -n "$XVESA" ]  && sed -i 's/1024x768x32/'"$XVESA"'/' /home/"$USER"/.xsession

sed -i 's/startx/ \/opt\/kiosk.sh/' /home/"$USER"/.profile
