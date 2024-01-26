#!/bin/bash

PREFIX=/opt/node-stat-client/3.0
DESDIR=/local/packages/22.04/src/packages/rdsk/ncbr-node-stat-client

set -o pipefail

# add cmake
module add cmake git

# determine number of available CPUs if not specified
if [ -z "$N" ]; then
    N=1
    type nproc &> /dev/null
    if type nproc &> /dev/null; then
        N=`nproc --all`
    fi
    if [ "$N" -gt 4 ]; then
        N=4
    fi
fi

echo ""
echo ">>> Number of CPUs for building: $N"
echo ""

# ------------------------------------------------------------------------------

set -o pipefail

cmake -DCMAKE_INSTALL_PREFIX="$PREFIX" -DSTAT_TARGET=client . 2>&1 | tee configure.log || exit 1
make -j "$N" 2>&1 | tee make.log || exit 1
make DESTDIR=$DESDIR install 2>&1 | tee install.log || exit 1

echo ""
# gen new control file
VERSION="`cat \"$DESDIR/DEBIAN/dpkgver\" 2>/dev/null`"
((VERSION++))
sed -e "s/VERSION/$VERSION/g" < "$DESDIR/DEBIAN/control.tmp" > "$DESDIR/DEBIAN/control"
echo "$VERSION" > "$DESDIR/DEBIAN/dpkgver"


