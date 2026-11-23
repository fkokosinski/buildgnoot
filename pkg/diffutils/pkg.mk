# Buildgnoot - diffutils package
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

DIFFUTILS_VERSION = 3.12
DIFFUTILS_URI = $(CONFIG_BG_GNU_MIRROR)/gnu/diffutils/diffutils-$(DIFFUTILS_VERSION).tar.xz
DIFFUTILS_SHA256 = 7c8b7f9fc8609141fdea9cece85249d308624391ff61dedaf528fcb337727dfd
DIFFUTILS_PATCHES = $(abspath pkg/diffutils/diffutils-disable-man.diff)
DIFFUTILS_ENV = $(bg-pkg-at-cross-env)

DIFFUTILS_AUTOTOOLS_CONFIGURE_FLAGS = \
       --prefix=$(bg-pkg-install-path) \
       --host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
       --disable-year2038 \
       ac_cv_func_strcasecmp=yes \
       gl_cv_func_strcasecmp_works=yes
DIFFUTILS_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
DIFFUTILS_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,diffutils))
$(eval $(call bg-build-autotools,diffutils))
