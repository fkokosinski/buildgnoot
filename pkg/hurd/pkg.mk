# Buildgnoot - GNU Hurd headers package
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

define bg-pkg-hurd
$(call bg-pkg-getprop-raw,$(1),VERSION) =  2336993cf542f430a424fbad426844594c80d213
$(call bg-pkg-getprop-raw,$(1),URI) = git://git.git.savannah.gnu.org/hurd/hurd.git
$$(eval $$(call bg-fetch-git,$(1)))

# package environment
ifneq ($(1),hurd-headers)
$(call bg-pkg-getprop-raw,$(1),ENV) = \
	$(bg-pkg-at-cross-env) \
	LDFLAGS="-ldl -lhurduser -lmachuser"
endif

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_RUN_AUTORECONF) = yes
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) = \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--disable-profile

# custom package configuration options
ifeq ($(1),hurd)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += --prefix=/
else
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += \
	--prefix=$$(bg-pkg-install-path) \
	--without-parted
endif

ifeq ($(1),hurd-headers)
$(call bg-pkg-getprop-raw,$(1),BDEPS) = mig
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = no_deps=t install-headers
endif

ifeq ($(1),hurd-stage-1)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = $$(bg-empty)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = install
endif

ifeq ($(1),hurd)
$(call bg-pkg-getprop-raw,$(1),BDEPS) += \
	e2fsprogs \
	hurd-stage-1 \
	libacpica \
	libdaemon \
	libgcrypt \
	libgpg-error \
	libirqhelp \
	libparted \
	libpciaccess \
	libshouldbeinlibc \
	libxcrypt \
	ncurses \
	rumpkernel \
	zlib
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += \
	CFLAGS="-Wno-error=strict-prototypes -I$$(bg-pkg-build-path)/include -I$$(bg-pkg-build-path)/usr/include" \
	LDFLAGS="-ldl -lhurduser -lmachuser $$$$$$$$LDFLAGS" \
	--enable-static-progs='ext2fs,iso9660fs,rumpdisk,pci-arbiter,acpi'
	
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = $$(bg-empty)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = DESTDIR=$$(bg-pkg-install-path) install
endif

ifeq ($(1),libirqhelp)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = libirqhelp
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = libirqhelp-install
endif

ifeq ($(1),libshouldbeinlibc)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = libshouldbeinlibc
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = libshouldbeinlibc-install
endif

$$(eval $$(call bg-build-autotools,$(1)))
endef

$(eval $(call bg-pkg-hurd,hurd-headers))
$(eval $(call bg-pkg-hurd,hurd-stage-1))
$(eval $(call bg-pkg-hurd,hurd))
$(eval $(call bg-pkg-hurd,libirqhelp))
$(eval $(call bg-pkg-hurd,libshouldbeinlibc))
