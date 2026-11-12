# Buildgnoot - gcc package
# Copyright (C) 2026 Filip Kokosiński

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

GCC_STAGE_1_VERSION = 16.2.0
GCC_STAGE_1_URI = https://ftpmirror.gnu.org/gnu/gcc/gcc-$(GCC_STAGE_1_VERSION)/gcc-$(GCC_STAGE_1_VERSION).tar.xz
GCC_STAGE_1_SHA256 = e6738e29597f733270731aa90600f37ffdc045079dfc27ec7e8192cc81085c3e

GCC_STAGE_1_BDEPS = binutils

GCC_STAGE_1_AUTOTOOLS_CONFIGURE_FLAGS = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
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
