# Buildgnoot - e2fsprogs package
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

E2FSPROGS_VERSION = 1.47.4
E2FSPROGS_URI = https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(E2FSPROGS_VERSION)/e2fsprogs-$(E2FSPROGS_VERSION).tar.gz
E2FSPROGS_SHA256 = da274408bebbfd13a5a2fc3cfc66e3ffff17c48534673aa67f88d49b99123b96
E2FSPROGS_ENV = $(bg-pkg-at-cross-env)

E2FSPROGS_AUTOTOOLS_CONFIGURE_FLAGS = \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--enable-elf-shlibs \
	--enable-libblkid \
	--enable-libuuid \
	--disable-uuidd
E2FSPROGS_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
E2FSPROGS_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,e2fsprogs))
$(eval $(call bg-build-autotools,e2fsprogs))
