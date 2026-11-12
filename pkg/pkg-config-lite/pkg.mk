# Buildgnoot - pkg-config-lite package
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

PKG_CONFIG_LITE_VERSION = 0.28-1
PKG_CONFIG_LITE_URI = https://downloads.sourceforge.net/project/pkgconfiglite/$(PKG_CONFIG_LITE_VERSION)/pkg-config-lite-$(PKG_CONFIG_LITE_VERSION).tar.gz
PKG_CONFIG_LITE_SHA256 = 21b76ec4e115ee30f9b3077a2506e48e8b837332ed4d30c9776502e69c6a29e5

PKG_CONFIG_LITE_AUTOTOOLS_CONFIGURE_FLAGS = \
	CFLAGS="-std=gnu17" \
	--prefix=$(bg-pkg-install-path) \
	--disable-host-tool

PKG_CONFIG_LITE_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
PKG_CONFIG_LITE_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,pkg-config-lite))
$(eval $(call bg-build-autotools,pkg-config-lite))
