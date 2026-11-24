# Buildgnoot - GNU Mach package
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

define bg-pkg-gnumach
$(call bg-pkg-getprop-raw,$(1),VERSION) = f349a52f3ac6f97024122f59d843f667206913fa
$(call bg-pkg-getprop-raw,$(1),URI) = https://https.git.savannah.gnu.org/git/hurd/gnumach.git/
$$(eval $$(call bg-fetch-git,$(1)))

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_RUN_AUTORECONF) = yes
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$$(bg-pkg-install-path) \
	--disable-user32

ifeq ($(1),gnumach-headers)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = install-data
endif

ifeq ($(1),gnumach)
$(call bg-pkg-getprop-raw,$(1),ENV) = $(bg-pkg-at-cross-env)
$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_CONFIGURE_FLAGS) += \
	LDFLAGS= \
	--exec-prefix=/tmp/throwitaway \
	--enable-kdb \
	--enable-kmsg \
	--disable-net-group \
	--disable-pcmcia-group \
	--disable-wireless-group

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_BUILD_TARGETS) = \
	gnumach.gz \
	gnumach \
	gnumach.msgids

$(call bg-pkg-getprop-raw,$(1),AUTOTOOLS_INSTALL_TARGETS) = \
	DESTDIR=$$(bg-pkg-install-path) \
	exec_bootdir=/boot \
	install
endif

$$(eval $$(call bg-build-autotools,$(1)))
endef

$(eval $(call bg-pkg-gnumach,gnumach-headers))
$(eval $(call bg-pkg-gnumach,gnumach))
