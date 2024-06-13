#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../env.sh

# paths
TARGET_ROOT="$TARGET_DIR"

# update os-release
pushd $GIT_ROOT
GIT_MOD_VERSION=$(git describe --tags)
popd

cat << EOF > $TARGET_ROOT/etc/os-release
NAME=Buildroot-Pellcorp
VERSION=-$GIT_MOD_VERSION
ID=buildroot
VERSION_ID=$GIT_MOD_VERSION
PRETTY_NAME="K1 $GIT_MOD_VERSION"
EOF
