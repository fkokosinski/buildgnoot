# Buildgnoot - libpciaccess package
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

LIBPCIACCESS_VERSION = 0.19
LIBPCIACCESS_URI = https://xorg.freedesktop.org/archive/individual/lib/libpciaccess-$(LIBPCIACCESS_VERSION).tar.xz
LIBPCIACCESS_SHA256 = 3c55aa86c82e54a4e3109786f0463530d53b36b6d1cfd14616454f985dd2aa43

LIBPCIACCESS_PATCHES = $(abspath pkg/libpciaccess/0001-Fix-compilation-for-GNU-Hurd.patch)

LIBPCIACCESS_MESON_SETUP_FLAGS = \
	--prefix=$(bg-pkg-install-path) \
	--includedir=$(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET)/include \
	--default-library=both \
	-Dzlib=disabled \
	--cross-file=$(abspath pkg/meta/meson/$(CONFIG_BG_TOOLCHAIN_TARGET))-cross-file.txt

$(eval $(call bg-fetch-tarball,libpciaccess))
$(eval $(call bg-build-meson,libpciaccess))
