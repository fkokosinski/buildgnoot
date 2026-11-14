# Buildgnoot - gcc package
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

GCC_STAGE_1_VERSION = 16.2.0
GCC_STAGE_1_URI = https://ftpmirror.gnu.org/gnu/gcc/gcc-$(GCC_STAGE_1_VERSION)/gcc-$(GCC_STAGE_1_VERSION).tar.xz
GCC_STAGE_1_SHA256 = e6738e29597f733270731aa90600f37ffdc045079dfc27ec7e8192cc81085c3e

GCC_STAGE_1_BDEPS = binutils

GCC_STAGE_1_AUTOTOOLS_CONFIGURE_FLAGS = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--with-sysroot=$(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-bootstrap \
	--disable-decimal-float \
	--disable-gcov \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-multilib \
	--disable-nls \
	--disable-shared \
	--disable-target-zlib \
	--disable-threads \
	--enable-languages=c \
	--with-newlib \
	--without-headers \
	--with-system-zlib

GCC_STAGE_1_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
GCC_STAGE_1_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,gcc-stage-1))
$(eval $(call bg-build-autotools,gcc-stage-1))

GCC_VERSION = 16.2.0
GCC_URI = https://ftpmirror.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.xz
GCC_SHA256 = e6738e29597f733270731aa90600f37ffdc045079dfc27ec7e8192cc81085c3e

GCC_BDEPS = binutils glibc-stage-1 gnumach-headers

GCC_AUTOTOOLS_CONFIGURE_FLAGS = \
	LDFLAGS_FOR_TARGET="-Wl,-rpath-link,$(bg-pkg-build-path)/lib" \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--with-sysroot=$(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--with-build-sysroot=$(bg-pkg-build-path) \
	--with-native-system-header-dir=/include \
	--disable-bootstrap \
	--disable-libgomp \
	--disable-multilib \
	--disable-nls \
	--enable-languages=c,c++ \
	--enable-shared \
	--enable-static \
	--enable-threads=posix \
	--with-libstdcxx-time \
	--with-system-zlib

GCC_AUTOTOOLS_BUILD_TARGETS = all-gcc all-target-libgcc all-target-libstdc++-v3
GCC_AUTOTOOLS_INSTALL_TARGETS = install-gcc install-target-libgcc install-target-libstdc++-v3

$(eval $(call bg-fetch-tarball,gcc))
$(eval $(call bg-build-autotools,gcc))
