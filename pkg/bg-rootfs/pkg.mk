# Buildgnoot - rootfs meta package
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

BG_ROOTFS_VERSION = $(BG_VERSION_MAJOR).$(BG_VERSION_MINOR).$(BG_VERSION_PATCH)
BG_ROOTFS_BDEPS = \
	bash \
	coreutils \
	glibc \
	gnumach \
	grub \
	hurd \
	libxcrypt \
	sed \
	shadow \
	$(bg-empty)

ifeq ($(CONFIG_PKG_BINUTILS),y)
BG_ROOTFS_BDEPS += binutils
endif

ifeq ($(CONFIG_PKG_DIFFUTILS),y)
BG_ROOTFS_BDEPS += diffutils
endif

ifeq ($(CONFIG_PKG_FINDUTILS),y)
BG_ROOTFS_BDEPS += findutils
endif

BG_ROOTFS_OVERLAY = $(abspath pkg/bg-rootfs/overlay)

bg-rootfs-download:
	@:

bg-rootfs-source:
	@:

bg-rootfs-build:
	@:

bg-rootfs-install: $(call bg-pkg-install-path,bg-rootfs).stamp

$(call bg-pkg-install-path,bg-rootfs).stamp: $(foreach p,$(BG_ROOTFS_BDEPS),$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_INSTALL_PATH)
	rm -rf $(call bg-pkg-install-path,bg-rootfs)
	mkdir -p $(call bg-pkg-install-path,bg-rootfs)/$(CONFIG_BG_ROOTFS_TARGET)

	pushd $(call bg-pkg-install-path,bg-rootfs)/$(CONFIG_BG_ROOTFS_TARGET)
	$(foreach p,$(BG_ROOTFS_BDEPS),rsync -av $(call bg-pkg-install-path,$(p))/ .;)
	$(foreach p,$(BG_ROOTFS_BDEPS),$(if $(call bg-pkg-overlay,$(p)),rsync -av $(call bg-pkg-overlay,$(p))/ .;,))
	rsync -av $(call bg-pkg-overlay,bg-rootfs)/ .
	popd

	touch $@

bg-rootfs: bg-rootfs-install

.PHONY: \
	bg-rootfs \
	bg-rootfs-install \
	bg-rootfs-build \
	bg-rootfs-source \
	bg-rootfs-download
