# Buildgnoot - binutils package
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

define bg-pkg-binutils
$(call bg-pkg-getprop-raw,$(1),VERSION) = 2.47
$(call bg-pkg-getprop-raw,$(1),URI) = https://ftpmirror.gnu.org/gnu/binutils/binutils-$$($(call bg-pkg-getprop-raw,$(1),VERSION)).tar.xz
$(call bg-pkg-getprop-raw,$(1),SHA256) = 154ab23b60070e8f27013c22977f1129425d67d1e8acd6e13010e617811e4cff
$$(eval $$(call bg-fetch-tarball,$(1)))

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$$(bg-pkg-install-path) \
	--with-sysroot=$(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-static \
	--disable-multilib \
	--disable-nls
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = $$(bg-space)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = install
$$(eval $$(call bg-build-autotools,$(1)))
endef

$(eval $(call bg-pkg-binutils,binutils))
