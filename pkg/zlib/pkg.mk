# Buildgnoot - zlib package
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

ZLIB_VERSION = 1.4
ZLIB_URI = https://zlib.net/zlib-$(ZLIB_VERSION).tar.gz
ZLIB_SHA256 = 02dd159783677a749c04adbdd02b55b8a2bcc7e054f51b76b549199a916ad584
ZLIB_ENV = $(bg-pkg-at-cross-env)

ZLIB_AUTOTOOLS_CONFIGURE_FLAGS = --prefix=$(bg-pkg-install-path)
ZLIB_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
ZLIB_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,zlib))
$(eval $(call bg-build-autotools,zlib))
