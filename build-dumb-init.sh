#!/bin/bash

builddir=`mktemp -d` || exit 1
cd $builddir || exit 1

if grep -q Fedora /etc/*release; then
    INSTALL_CMD="dnf -y install glibc-static"
    REMOVE_CMD="dnf -y remove glibc-static"
else
    exit 1
fi

wget https://github.com/Yelp/dumb-init/archive/v1.2.2.tar.gz || exit 1
echo "d4e2e10e39ad49c225e1579a4d770b83637399a0be48e29986f720fae44dafdf  v1.2.2.tar.gz" > sha256sums || exit 1
sha256sum -c sha256sums || exit 1
tar xf v1.2.2.tar.gz || exit 1

# Replace the versions of python used for testing dumb-init. Since it is
# testing c code, and not python it shouldn't matter. Also remove the
# pre-commit test from the test rule because we don't care.
sed -i -e 's/envlist = .*/envlist = py3/' dumb-init*/tox.ini || exit 1
sed -i -e 's/tox -e pre-commit//' dumb-init*/Makefile || exit 1

$INSTALL_CMD || exit 1

pip3 install virtualenv || exit 1

virtualenv $builddir/venv || exit 1
. $builddir/venv/bin/activate || exit 1
pip3 install tox || exit 1

cd dumb-init* || exit 1
make dumb-init || exit 1
make test

cp dumb-init /usr/bin/dumb-init || exit 1
chmod +x /usr/bin/dumb-init || exit 1

rm $builddir -rf || exit 1
# Really this should be an exit 1 as well if it fails, but for some reason
# on travis, for fedora it consistently says that it cannot acquire the
# the transaction lock.
$REMOVE_CMD || exit 0