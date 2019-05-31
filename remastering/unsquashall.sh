#!/bin/bash
#for i in $( ls ../*tcz); do
for i in $( cat optional.lst); do
if [ ! $i == "unsquashall.sh" ] && [ -f $i ]; then
    echo $i
    unsquashfs -f $i
fi
done
