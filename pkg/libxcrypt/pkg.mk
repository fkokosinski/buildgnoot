# Buildgnoot - libxcrypt package
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

LIBXCRYPT_VERSION = 4.5.2
LIBXCRYPT_URI = https://github.com/besser82/libxcrypt/releases/download/v$(LIBXCRYPT_VERSION)/libxcrypt-$(LIBXCRYPT_VERSION).tar.xz
LIBXCRYPT_SHA256 = 71513a31c01a428bccd5367a32fd95f115d6dac50fb5b60c779d5c7942aec071
LIBXCRYPT_ENV = $(bg-pkg-at-cross-env)
LIBXCRYPT_AUTOTOOLS_CONFIGURE_FLAGS = \
	CFLAGS=-Wno-error=discarded-qualifiers \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--enable-hashes=strong,glibc \
	--enable-obsolete-api=no \
	--disable-failure-tokens

LIBXCRYPT_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
LIBXCRYPT_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,libxcrypt))
$(eval $(call bg-build-autotools,libxcrypt))
