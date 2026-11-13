# Buildgnoot - glibc package
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

GLIBC_STAGE_1_VERSION = 2.44
GLIBC_STAGE_1_URI = https://ftpmirror.gnu.org/glibc/glibc-$(GLIBC_STAGE_1_VERSION).tar.gz
GLIBC_STAGE_1_SHA256 = 1217fc41ac7fb1f310c8c32b9c6c009cc769398d4b367b6aa57be0bb3ea8c1ef
GLIBC_STAGE_1_BDEPS = \
	binutils \
	gcc-stage-1 \
	hurd-headers \
	gnumach-headers \
	mig

GLIBC_STAGE_1_AUTOTOOLS_CONFIGURE_FLAGS = \
	CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
	AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
	RANLIB=$(CONFIG_BG_TOOLCHAIN_TARGET)-ranlib \
	libc_cv_ctors_header=yes \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=/usr \
	--disable-nscd \
	--disable-profile \
	--enable-add-ons=libpthread \
	--enable-obsolete-rpc \
	--with-headers=$(bg-pkg-build-path)/include

GLIBC_STAGE_1_AUTOTOOLS_BUILD_TARGETS = $(bg-space)
GLIBC_STAGE_1_AUTOTOOLS_INSTALL_TARGETS = install_root=$(bg-pkg-install-path) install

$(eval $(call bg-fetch-tarball,glibc-stage-1))
$(eval $(call bg-build-autotools,glibc-stage-1))
