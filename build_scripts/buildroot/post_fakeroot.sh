#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh
source $BASE_DIR/.mod_env

export VARIANT_BUILDROOT_OUT=$BUILDROOT_OUT/$MOD_VARIANT

if [ "$MOD_VARIANT" = "simple" ]; then
	rm -rf $VARIANT_BUILDROOT_OUT/target/opt/
    mkdir -p $VARIANT_BUILDROOT_OUT/target/opt/
    mv $VARIANT_BUILDROOT_OUT/target/usr $VARIANT_BUILDROOT_OUT/target/opt/
    mv $VARIANT_BUILDROOT_OUT/target/bin $VARIANT_BUILDROOT_OUT/target/opt/
    mv $VARIANT_BUILDROOT_OUT/target/lib $VARIANT_BUILDROOT_OUT/target/opt/
    mv $VARIANT_BUILDROOT_OUT/target/sbin $VARIANT_BUILDROOT_OUT/target/opt/
    mv $VARIANT_BUILDROOT_OUT/target/etc $VARIANT_BUILDROOT_OUT/target/opt/
    rm $VARIANT_BUILDROOT_OUT/target/dev
    rm $VARIANT_BUILDROOT_OUT/target/mnt
    rm $VARIANT_BUILDROOT_OUT/target/proc
    rm $VARIANT_BUILDROOT_OUT/target/root
    rm $VARIANT_BUILDROOT_OUT/target/run
    rm $VARIANT_BUILDROOT_OUT/target/sys
    rm $VARIANT_BUILDROOT_OUT/target/dev
    mkdir -p $VARIANT_BUILDROOT_OUT/target/tmp/nginx
    mkdir -p $VARIANT_BUILDROOT_OUT/target/var/cache
    ln -sf $VARIANT_BUILDROOT_OUT/target/tmp/nginx /var/cache/
fi
