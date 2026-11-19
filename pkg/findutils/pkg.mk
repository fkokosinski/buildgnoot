# Buildgnoot - findutils package
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

FINDUTILS_VERSION = 4.10.0
FINDUTILS_URI = https://ftpmirror.gnu.org/findutils/findutils-$(FINDUTILS_VERSION).tar.xz
FINDUTILS_SHA256 = 1387e0b67ff247d2abde998f90dfbf70c1491391a59ddfecb8ae698789f0a4f5

FINDUTILS_AUTOTOOLS_CONFIGURE_FLAGS = \
       CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
       AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
       RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
       --prefix=$(bg-pkg-install-path) \
       --host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
       --disable-year2038
FINDUTILS_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
FINDUTILS_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,findutils))
$(eval $(call bg-build-autotools,findutils))
