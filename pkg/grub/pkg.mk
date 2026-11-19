# Buildgnoot - grub package
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

GRUB_VERSION = 2.14
GRUB_URI = https://ftpmirror.gnu.org/gnu/grub/grub-$(GRUB_VERSION).tar.xz
GRUB_SHA256 = d0415fbb3e739237064e173743a6e5f60c33a81ec02a069cc9152d80efff4967

GRUB_AUTOTOOLS_CONFIGURE_FLAGS = \
       CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
       AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
       RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
       HOST_LDFLAGS="-ldl -lhurduser -lmachuser" \
       --prefix=$(bg-pkg-install-path) \
       --host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
       --disable-efiemu \
       --disable-werror \
       --enable-grub-mkfont=no \
       --with-bootdir=$(bg-pkg-install-path)/boot

GRUB_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
GRUB_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,grub))
$(eval $(call bg-build-autotools,grub))
