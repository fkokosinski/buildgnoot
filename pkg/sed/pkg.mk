# Buildgnoot - sed package
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

SED_VERSION = 4.9
SED_URI = $(CONFIG_BG_GNU_MIRROR)/gnu/sed/sed-$(SED_VERSION).tar.xz
SED_SHA256 = 6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181

SED_AUTOTOOLS_CONFIGURE_FLAGS = \
       CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
       AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
       RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
       --prefix=$(bg-pkg-install-path) \
       --host=$(CONFIG_BG_TOOLCHAIN_TARGET)
SED_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
SED_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,sed))
$(eval $(call bg-build-autotools,sed))
