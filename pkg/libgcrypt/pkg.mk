# Buildgnoot - libgcrypt package
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

LIBGCRYPT_VERSION = 1.11.1
LIBGCRYPT_URI = https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-$(LIBGCRYPT_VERSION).tar.bz2
LIBGCRYPT_SHA256 = 24e91c9123a46c54e8371f3a3a2502f1198f2893fbfbf59af95bc1c21499b00e
LIBGCRYPT_BDEPS = libgpg-error

LIBGCRYPT_AUTOTOOLS_CONFIGURE_FLAGS = \
	CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
	AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
	RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-padlock-support \
	--with-gpg-error-prefix=$(bg-pkg-install-path) \
	--disable-asm
LIBGCRYPT_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
LIBGCRYPT_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,libgcrypt))
$(eval $(call bg-build-autotools,libgcrypt))
