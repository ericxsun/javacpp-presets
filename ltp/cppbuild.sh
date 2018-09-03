#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "${PLATFORM}" ]]; then
    pushd ..
    bash cppbuild.sh "$@" ltp
    popd
    exit
fi

LTP_VERSION=3.4.1
download https://github.com/ericxsun/ltp/archive/v${LTP_VERSION}.tar.gz ltp-${LTP_VERSION}.tar.gz

mkdir -p "${PLATFORM}${EXTENSION}"
cd "${PLATFORM}${EXTENSION}"

#[ -d "ltp-${LTP_VERSION}" ] && rm -rf "ltp-${LTP_VERSION}"

INSTALL_PATH=`pwd`
echo "Decompressing archives..."
tar --totals -xzf ../ltp-${LTP_VERSION}.tar.gz

case ${PLATFORM} in
     linux-x86)
        export CC="gcc -m32"
        export CXX="g++ -m32"
        ;;
    linux-x86_64)
        export CC="gcc -m64"
        export CXX="g++ -m64"
        ;;
    macosx-*)
        export CC="clang"
        export CXX="clang++"
        ;;
    *)
        echo "Error: Platform \"${PLATFORM}\" is not supported"
        return 0
        ;;
esac

cd ltp-${LTP_VERSION}

./configure
make -j ${MAKEJ} CC="$CC" CXX="$CXX"
make install > /dev/null

cp -a include lib ../

unset CC
unset CXX

cd ../..
