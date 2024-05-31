#!/bin/sh

TAG="symlink-serial-dev"


devpath=$(readlink -f /sys/class/tty/$MDEV)
serial_id_path=/dev/serial/by-id
serial=
product=
manufacturer=
interface=

start() {
    while [ ! -z "$devpath" ]  && [ "$devpath" != "/" ];
    do

	if [ ! -z "$serial" ] && [ ! -z "$product" ] && [ ! -z "$manufacturer" ] && [ ! -z "$interface" ];
	then
	    mkdir -p $serial_id_path
	    ln -sf /dev/$MDEV $serial_id_path/usb-"$manufacturer"_"$product"_"$serial"-if"$interface"
	fi

	if [ -f $devpath/serial ] && [ -z "$serial" ];
	then
	    serial="$(cat ${devpath}/serial)"
	fi

	if [ -f $devpath/product ] && [ -z "$product" ];
	then
	    product="$(cat ${devpath}/product)"
	fi

	if [ -f $devpath/manufacturer ] && [ -z "$manufacturer" ];
	then
	    manufacturer="$(cat ${devpath}/manufacturer)"
	fi

	if [ -f $devpath/bInterfaceNumber ] && [ -z "$interface" ];
	then
	    interface="$(cat ${devpath}/bInterfaceNumber)"
	fi

	devpath="$(dirname $devpath)"
    done
}

stop() {
    find /dev/serial/by-id -maxdepth 1 -type l -exec test "$(readlink {})" != "/dev/$MDEV" \; -print0 | xargs rm -f
}


logger -t $TAG "received ACTION=$ACTION /dev/$MDEV"

case "$ACTION" in
    add)
        start
        ;;
    remove)
        stop
        ;;
    *)
        logger -t $TAG "ACTION=$ACTION unsupported"
        exit 1
esac
