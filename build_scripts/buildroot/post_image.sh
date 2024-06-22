#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh
source $BASE_DIR/.mod_env

export VARIANT_BUILDROOT_OUT=$BUILDROOT_OUT/$MOD_VARIANT

if [ "$MOD_VARIANT" = "simple" ] && [ -f $VARIANT_BUILDROOT_OUT/images/rootfs.tar ]; then
	echo "Deleting unecessary dirs from rootfs.tar ..."
#	tar -f $VARIANT_BUILDROOT_OUT/images/rootfs.tar --delete ./dev ./media ./mnt ./opt ./proc ./root ./run ./sys ./tmp ./var
#    [ -f $VARIANT_BUILDROOT_OUT/images/rootfs.tar.xz ] && rm $VARIANT_BUILDROOT_OUT/images/rootfs.tar.xz

#    echo "Creating rootfs.tar.xz ..."
	xz -zk $VARIANT_BUILDROOT_OUT/images/rootfs.tar 
fi
