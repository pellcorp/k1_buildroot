#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh
source $BASE_DIR/.mod_env

# built in patchelf for buldroot corrupts libs on MIPS need 22.04 ubuntu or debian bookworm patchelf
function patch_file() {
    file="$1"

    rpath="$(/usr/bin/patchelf --print-rpath "$file" 2> /dev/null)"
    # not an elf file so skip it
    if [ $? -ne 0 ]; then
        return 0
    fi

    interpreter=$(/usr/bin/patchelf --print-interpreter "$file" 2> /dev/null)
    
    # do not fix interpreter on anything but those binaries that already have one
    if [ "$interpreter" != "" ] && [[ $interpreter != /opt* ]]; then
        echo "Fixing interpreter [$file] ..."
        /usr/bin/patchelf --set-interpreter /opt${interpreter} "$file"
    fi
    
    # this is a somewhat pointless test as we should never be running this
    # script twice across the target directory
    if [ "$rpath" = "" ]; then
        objdump -p "$file" 2> /dev/null | grep "NEEDED" > /dev/null
        # only update rpath for files that NEED other libs
        if [ $? -eq 0 ]; then
            echo "Fixing rpath [$file] ..."
            /usr/bin/patchelf --set-rpath '/opt/lib:/opt/usr/lib' "$file"
        fi
    fi
}

pushd $GIT_ROOT > /dev/null
GIT_VERSION=$(git describe --tags)
popd > /dev/null

cat << EOF > $TARGET_DIR/etc/os-release
NAME=pellcorp
VERSION=-$GIT_VERSION
ID=buildroot
VERSION_ID=$GIT_VERSION
PRETTY_NAME="pellcorp $GIT_VERSION"
EOF

if [ "$MOD_VARIANT" = "simple" ]; then
    export -f patch_file
    find "${TARGET_DIR}" -type f | xargs -r -P "${PARALLEL_JOBS:-1}" -I {} bash -c 'patch_file "${@}"' _ {}
fi

mkdir -p $TARGET_DIR/usr/share/

# because we will be prebuilding these at some stage it makes way more sense to bundle them into the rootfs
tar -xf $GIT_ROOT/prebuilt/klippy-env.tar.xz -C $TARGET_DIR/usr/share/
tar -xf $GIT_ROOT/prebuilt/moonraker-env.tar.xz -C $TARGET_DIR/usr/share/
