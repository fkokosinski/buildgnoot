# Buildgnoot - shadow package
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

SHADOW_VERSION = 4.14.2
SHADOW_URI = https://github.com/shadow-maint/shadow/releases/download/$(SHADOW_VERSION)/shadow-$(SHADOW_VERSION).tar.xz
SHADOW_SHA256 = 25df30589d2e31aaff14576d03f980bb578e6d446891da6d24de1e5a09a38949
SHADOW_PATCHES = \
       $(abspath pkg/shadow/patches/shadow-utmp.patch) \
       $(abspath pkg/shadow/patches/hurd-compatible.patch)
SHADOW_BDEPS = libxcrypt
SHADOW_ENV = $(bg-pkg-at-cross-env)

SHADOW_AUTOTOOLS_CONFIGURE_FLAGS = \
       --prefix=$(bg-pkg-install-path) \
       --host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
       --enable-subordinate-ids=yes \
       --disable-dependency-tracking \
       --without-libbsd
       
SHADOW_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
SHADOW_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,shadow))
$(eval $(call bg-build-autotools,shadow))
