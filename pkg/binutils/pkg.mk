# Buildgnoot - binutils package
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

BINUTILS_VERSION = 2.47
BINUTILS_URI = https://ftpmirror.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.xz
BINUTILS_SHA256 = 154ab23b60070e8f27013c22977f1129425d67d1e8acd6e13010e617811e4cff

BINUTILS_AUTOTOOLS_CONFIGURE_FLAGS = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--disable-static \
	--disable-multilib \
	--disable-nls
BINUTILS_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
BINUTILS_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,binutils))
$(eval $(call bg-build-autotools,binutils))
