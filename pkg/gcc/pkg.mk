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

define bg-pkg-gcc
$(call bg-pkg-getprop-raw,$(1),VERSION) = 16.2.0
$(call bg-pkg-getprop-raw,$(1),URI) = $(CONFIG_BG_GNU_MIRROR)/gnu/gcc/gcc-$$($(call bg-pkg-getprop-raw,$(1),VERSION))/gcc-$$($(call bg-pkg-getprop-raw,$(1),VERSION)).tar.xz
$(call bg-pkg-getprop-raw,$(1),SHA256) = e6738e29597f733270731aa90600f37ffdc045079dfc27ec7e8192cc81085c3e
$$(eval $$(call bg-fetch-tarball,$(1)))

$(call bg-pkg-getprop-raw,$(1),BDEPS) = host-binutils
ifeq ($(1),host-gcc)
$(call bg-pkg-getprop-raw,$(1),BDEPS) += glibc-stage-1 gnumach-headers
endif

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$$(bg-pkg-install-path) \
	--with-sysroot=$(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-bootstrap \
	--disable-libgomp \
	--disable-multilib \
	--disable-nls \
	--with-system-zlib

ifeq ($(1),host-gcc-stage-1)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += \
	--disable-decimal-float \
	--disable-gcov \
	--disable-libatomic \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-shared \
	--disable-target-zlib \
	--disable-threads \
	--enable-languages=c \
	--with-newlib \
	--without-headers
endif

ifeq ($(1),host-gcc)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += \
	LDFLAGS= \
	LDFLAGS_FOR_TARGET="-Wl,-rpath-link,$(bg-pkg-build-path)/lib" \
	--with-build-sysroot=$$(bg-pkg-build-path) \
	--with-native-system-header-dir=/include \
	--enable-languages=c,c++ \
	--enable-shared \
	--enable-static \
	--enable-threads=posix \
	--with-libstdcxx-time
endif

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = $$(bg-space)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = install
$$(eval $$(call bg-build-autotools,$(1)))
endef

$(eval $(call bg-pkg-gcc,host-gcc-stage-1))
$(eval $(call bg-pkg-gcc,host-gcc))
