# Buildgnoot - libgpg-error package
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

LIBGPG_ERROR_VERSION = 1.55
LIBGPG_ERROR_URI = https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-$(LIBGPG_ERROR_VERSION).tar.bz2
LIBGPG_ERROR_SHA256 = 95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78
LIBGPG_ERROR_ENV = $(bg-pkg-at-cross-env)

LIBGPG_ERROR_AUTOTOOLS_CONFIGURE_FLAGS = \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET)
LIBGPG_ERROR_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
LIBGPG_ERROR_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,libgpg-error))
$(eval $(call bg-build-autotools,libgpg-error))
