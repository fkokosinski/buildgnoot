# Buildgnoot - libdaemon package
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

LIBDAEMON_VERSION = 0.14
LIBDAEMON_URI = https://0pointer.de/lennart/projects/libdaemon/libdaemon-$(LIBDAEMON_VERSION).tar.gz
LIBDAEMON_SHA256 = fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834
LIBDAEMON_ENV = $(bg-pkg-at-cross-env)

LIBDAEMON_AUTOTOOLS_CONFIGURE_FLAGS = \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
    ac_cv_func_getpgrp_void=no \
    ac_cv_func_setpgrp_void=yes \
    ac_cv_func_memcmp_working=yes \
    rb_cv_binary_elf=no \
    rb_cv_negative_time_t=no
LIBDAEMON_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
LIBDAEMON_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,libdaemon))
$(eval $(call bg-build-autotools,libdaemon))
