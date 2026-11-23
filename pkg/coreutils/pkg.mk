# Buildgnoot - coreutils package
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

COREUTILS_VERSION = 9.5
COREUTILS_URI = $(CONFIG_BG_GNU_MIRROR)/gnu/coreutils/coreutils-$(COREUTILS_VERSION).tar.xz
COREUTILS_SHA256 = cd328edeac92f6a665de9f323c93b712af1858bc2e0d88f3f7100469470a1b8a

COREUTILS_AUTOTOOLS_CONFIGURE_FLAGS = \
	CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
	AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
	RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
	LIBS="-ldl -lhurduser -lmachuser" \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--enable-install-program=hostname \
	--disable-year2038 \
	fu_cv_sys_stat_statfs2_bsize=yes \
	gl_cv_func_working_mkstemp=yes
COREUTILS_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
COREUTILS_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,coreutils))
$(eval $(call bg-build-autotools,coreutils))
