#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh
source $BASE_DIR/.mod_env

export VARIANT_BUILDROOT_OUT=$BUILDROOT_OUT/$MOD_VARIANT

if [ "$MOD_VARIANT" = "simple" ] && [ -f $VARIANT_BUILDROOT_OUT/images/rootfs.tar ]; then
	echo "Deleting unecessary files from skeleton..."
	tar -f $VARIANT_BUILDROOT_OUT/images/rootfs.tar --delete dev etc media mnt opt proc root run sys tmp
	gzip -k $VARIANT_BUILDROOT_OUT/images/rootfs.tar 
fi

