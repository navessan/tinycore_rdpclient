#!/bin/bash

cd ../squashfs-root
zcat ../core.gz | cpio -i -H newc -d