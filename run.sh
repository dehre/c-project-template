#!/bin/bash

USAGE="Usage: $(basename $0) {debug | release | asan | ubsan | tsan} <target> [<arg> ...]"

TYPE=$1
BUILD_DIR=./build/debug
TARGET=$2

case "$1" in
--help | -h)
    echo "$USAGE"
    exit 0
    ;;
debug)
    BUILD_DIR=./build/debug
    ;;
release)
    BUILD_DIR=./build/release
    ;;
asan)
    BUILD_DIR=./build/asan
    ;;
ubsan)
    BUILD_DIR=./build/ubsan
    ;;
tsan)
    BUILD_DIR=./build/tsan
    ;;
*)
    echo -e "Invalid option $1\n$USAGE" >&2
    exit 1
    ;;
esac

if [ ! -d $BUILD_DIR ]; then
    echo "$TYPE not built yet" >&2
    exit 1
fi

if [ ! -f "$BUILD_DIR/apps/$TARGET" ]; then
    echo "Invalid target $TARGET" >&2
    exit 1
fi

# the other args, starting with $3, are given to the executable
"$BUILD_DIR"/apps/"$TARGET" "${@:3}"
