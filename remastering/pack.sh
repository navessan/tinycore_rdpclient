#!/bin/bash

cd ../squashfs-root
find | cpio -o -H newc | gzip -2 > ../tc.gz
