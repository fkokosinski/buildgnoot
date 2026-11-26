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

define bg-pkg-glibc
$(call bg-pkg-getprop-raw,$(1),VERSION) = 2.44
$(call bg-pkg-getprop-raw,$(1),URI) = $(CONFIG_BG_GNU_MIRROR)/gnu/glibc/glibc-$$($(call bg-pkg-getprop-raw,$(1),VERSION)).tar.gz
$(call bg-pkg-getprop-raw,$(1),SHA256) = 1217fc41ac7fb1f310c8c32b9c6c009cc769398d4b367b6aa57be0bb3ea8c1ef
$(call bg-pkg-getprop-raw,$(1),PATCHES) = $(abspath pkg/glibc/tg-mach-hurd-link.diff)
$$(eval $$(call bg-fetch-tarball,$(1)))

$(call bg-pkg-getprop-raw,$(1),BDEPS) = \
	host-binutils \
	hurd-headers \
	gnumach-headers \
	mig

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) = \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix= \
	--disable-nscd \
	--disable-profile \
	--enable-add-ons=libpthread \
	--enable-obsolete-rpc \
	--with-headers=$$(bg-pkg-build-path)/include

$(call bg-pkg-getprop-raw,$(1),ENV) = $(bg-pkg-at-cross-env)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = $$(bg-space)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = install_root=$$(bg-pkg-install-path) install

ifeq ($(1),glibc-stage-1)
$(call bg-pkg-getprop-raw,$(1),BDEPS) += host-gcc-stage-1
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += libc_cv_ctors_header=yes
endif

ifeq ($(1),glibc)
$(call bg-pkg-getprop-raw,$(1),BDEPS) += host-gcc
endif

$$(eval $$(call bg-build-autotools,$(1)))
endef

$(eval $(call bg-pkg-glibc,glibc-stage-1))
$(eval $(call bg-pkg-glibc,glibc))
