#!/usr/bin/env bash

# Buildgnoot - rumpkernel build script
# Copyright (C) 2026 Filip Kokosiński
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# TODO:
# - general cleanup - can this be made more cleanly?
# - basic hardening, it's not even checking commandline args

set -euxo pipefail

source .config

build_path=$1
sysroot=$(realpath $2)
if [[ "${CONFIG_BG_TOOLCHAIN_TARGET}" == "x86_64-gnu" ]]; then
  nbarch="amd64"
else
  echo "$0: unknown architecture!"
  exit 1
fi
  
export HOST_CC=gcc
export HOST_CPPFLAGS=-D_GNU_SOURCE
export TARGET_AR=${CONFIG_BG_TOOLCHAIN_TARGET}-ar
export TARGET_CC=${CONFIG_BG_TOOLCHAIN_TARGET}-gcc
export TARGET_CXX=${CONFIG_BG_TOOLCHAIN_TARGET}-g++
export TARGET_LD=${CONFIG_BG_TOOLCHAIN_TARGET}-ld
export TARGET_MIG=${CONFIG_BG_TOOLCHAIN_TARGET}-mig
export TARGET_NM=${CONFIG_BG_TOOLCHAIN_TARGET}-nm
export MIG=${CONFIG_BG_TOOLCHAIN_TARGET}-mig
export _GCC_CRTENDS= _GCC_CRTEND= _GCC_CRTBEGINS= _GCC_CRTBEGIN= _GCC_CRTI= _GCC_CRTN=

export BSDOBJDIR=${build_path}/buildrump.sh/src/obj
export BSDOBJECTDIR=${build_path}/buildrump.sh/src/obj
export MAKEOBJDIRPREFIX=${build_path}/buildrump.sh/src/obj

pushd ${build_path}/buildrump.sh/src/lib/librumpuser
  ./configure --host=${CONFIG_BG_TOOLCHAIN_TARGET}
popd

buildrump_cppflags=(
  -I${build_path}/buildrump.sh/src/obj/destdir.${nbarch}/usr/include

  -D_FILE_OFFSET_BITS=64
  -DRUMP_REGISTER_T=int
  -DRUMPUSER_CONFIG=yes
  -DNO_PCI_MSI_MSIX=yes
  -DNUSB_DMA=1
  -DPAE
  -DBUFPAGES=16

  # Workaround broken open() call
  -U_FORTIFY_SOURCE

  # libipsec doesn't get CWARNFLAGS, apparently
  -Wno-error=unused-but-set-variable
)

buildrump_warnflags=(
  -Wno-error=unused-but-set-variable
  -Wno-error=maybe-uninitialized
  -Wno-error=address-of-packed-member
  -Wno-error=unused-variable
  -Wno-error=stack-protector
  -Wno-error=array-parameter
  -Wno-error=array-bounds
  -Wno-error=stringop-overflow
  -Wno-error=int-to-pointer-cast
  -Wno-error=incompatible-pointer-types
  -Wno-error=unterminated-string-initialization
  -Wno-error=format-nonliteral
  -Wno-error=sign-compare
)

buildrump_args=(
  -V TOOLS_BUILDRUMP=yes
  -V MKBINUTILS=no
  -V MKGDB=no
  -V MKGROFF=no
  -V MKDTRACE=no
  -V MKZFS=no

  -V TOPRUMP=${build_path}/buildrump.sh/src/sys/rump
  -V BUILDRUMP_CPPFLAGS="-Wno-error=stringop-overread"
  -V RUMPUSER_EXTERNAL_DPLIBS=pthread

  -V CPPFLAGS="${buildrump_cppflags[*]}"
  -V CWARNFLAGS="${buildrump_warnflags[*]}"
  -V TARGET_LDADD="-Wl,--sysroot=${sysroot} -B${sysroot}/lib -B${build_path}/lib -L${build_path}/lib"

  -V _GCC_CRTENDS="" -V _GCC_CRTEND=""
  -V _GCC_CRTBEGINS="" -V _GCC_CRTBEGIN=""
  -V _GCC_CRTI="" -V _GCC_CRTN=""
  -V MIG=${MIG}

  -m ${nbarch}
  -U -u
  -j $(nproc)
  # -j 1
  -T ${build_path}/obj/tooldir
)

pushd ${build_path}/buildrump.sh/src/
  ./build.sh "${buildrump_args[@]}" tools rump
popd

export NBMAKE=${build_path}/obj/tooldir/bin/nbmake-amd64

pushd ${build_path}/buildrump.sh/src/lib/librumpuser
  ${NBMAKE} \
    RUMPRUN=true \
    MIG=${MIG} \
    CFLAGS="-I${build_path}/buildrump.sh/src/obj${build_path}/buildrump.sh/src/destdir.amd64/usr/include" \
    -j $(nproc) \
    dependall
popd

pushd ${build_path}/pci-userspace/src-gnu
  ${NBMAKE} \
    MIG=${MIG} \
    dependall
popd
