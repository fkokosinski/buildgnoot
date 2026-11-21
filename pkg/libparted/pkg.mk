# Buildgnoot - libparted package
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

LIBPARTED_VERSION = 3.8
LIBPARTED_URI = https://ftpmirror.gnu.org/parted/parted-$(LIBPARTED_VERSION).tar.xz
LIBPARTED_SHA256 = a2b7811f47b0ddb1f7b1d0aa456f7c1270da70708ce231c2fe054c7199eafa63

LIBPARTED_BDEPS = \
	e2fsprogs \
	hurd-stage-1

LIBPARTED_AUTOTOOLS_CONFIGURE_FLAGS = \
	CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
	AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
	RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
	PKG_CONFIG=pkg-config \
	CPPFLAGS="-I$(bg-pkg-build-path)/include -DUUID_STR_LEN=37" \
	LIBS="-luuid" \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-device-mapper \
	--disable-nls \
	--without-readline \
	--enable-shared \
	--enable-static

LIBPARTED_AUTOTOOLS_BUILD_TARGETS = lib libparted
LIBPARTED_AUTOTOOLS_INSTALL_TARGETS = install include install

$(eval $(call bg-fetch-tarball,libparted))
$(eval $(call bg-build-autotools,libparted))
