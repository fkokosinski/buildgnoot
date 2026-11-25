# Buildgnoot - ncurses package
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

NCURSES_VERSION = 6.4
NCURSES_URI = $(CONFIG_BG_GNU_MIRROR)/gnu/ncurses/ncurses-$(NCURSES_VERSION).tar.gz
NCURSES_SHA256 = 6931283d9ac87c5073f30b6290c4c75f21632bb4fc3603ac8100812bed248159
NCURSES_ENV = $(bg-pkg-at-cross-env)

NCURSES_AUTOTOOLS_CONFIGURE_FLAGS = \
	LDFLAGS="-lpthread" \
	CPPFLAGS="-P" \
	CFLAGS="-std=gnu17" \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--with-shared \
	--with-debug \
	--without-ada \
	--with-termlib=tinfo \
	--enable-overwrite \
	--without-cxx-binding \
	--disable-stripping \
	--disable-relink \
	--with-versioned-syms \
	--enable-widec
NCURSES_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
NCURSES_AUTOTOOLS_INSTALL_TARGETS = \
	TIC_PATH=$(shell command -v tic) \
	install.libs \
	install.includes

$(eval $(call bg-fetch-tarball,ncurses))
$(eval $(call bg-build-autotools,ncurses))
