#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh
source $BASE_DIR/.mod_env

export VARIANT_BUILDROOT_OUT=$BUILDROOT_OUT/$MOD_VARIANT

function patch_file() {
    file="$1"

    grep -q "#!/usr/bin/python" $file > /dev/null
    if [ $? -eq 0 ]; then
        echo "Fixing python header [$file] ..."
        sed -i 's:#!/usr/bin/python:/#!/opt/usr/bin/python/g' $file
    fi

    rpath="$(/usr/bin/patchelf --print-rpath "${file}" 2> /dev/null)"
    if [ $? -ne 0 ]; then
        return 0
    fi

    # built in patchelf for buldroot corrupts libs on MIPS need 22.04 ubuntu or debian bookworm patchelf
    interpreter=$(/usr/bin/patchelf --print-interpreter $file 2> /dev/null)
    
    # do not fix interpreter on anything but those binaries that already have one
    if [ "$interpreter" != "" ] && [[ $interpreter != /opt* ]]; then
        echo "Fixing interpreter [$file] ..."
        /usr/bin/patchelf --set-interpreter /opt${interpreter} $file
    fi
    
    # so anything in a bin directory or python so files
    if [ "$rpath" = "" ]; then
        if [[ $file = */sbin* ]] || [[ $file = */bin* ]] || [[ $file = */python*.so ]]; then
            echo "Fixing rpath [$file] ..."
            /usr/bin/patchelf --set-rpath '/opt/lib:/opt/usr/lib' $file
        fi
    fi
}

# paths
TARGET_ROOT="$TARGET_DIR"

# update os-release
pushd $GIT_ROOT
GIT_VERSION=$(git describe --tags)
popd

cat << EOF > $TARGET_ROOT/etc/os-release
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
