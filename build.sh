#!/bin/bash

USAGE="Usage: $(basename $0) [debug | release | asan | ubsan | tsan] [clean]"

TYPE=DEBUG
BUILD_DIR=./build/debug
CLEAN=

for arg; do
    case "$arg" in
    --help | -h)
        echo "$USAGE"
        exit 0
        ;;
    debug)
        TYPE=DEBUG
        BUILD_DIR=./build/debug
        ;;
    release)
        TYPE=RELEASE
        BUILD_DIR=./build/release
        ;;
    asan)
        TYPE=ASAN
        BUILD_DIR=./build/asan
        ;;
    ubsan)
        TYPE=UBSAN
        BUILD_DIR=./build/ubsan
        ;;
    tsan)
        TYPE=TSAN
        BUILD_DIR=./build/tsan
        ;;
    clean) CLEAN=1 ;;
    *)
        echo -e "Invalid option $arg\n$USAGE" >&2
        exit 1
        ;;
    esac
done

cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=$TYPE

if [ -n "$CLEAN" ]; then
    cmake --build $BUILD_DIR --target clean
fi

cmake --build $BUILD_DIR
