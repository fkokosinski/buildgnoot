# Buildgnoot - toolchain meta package
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

BG_TOOLCHAIN_VERSION = $(BG_VERSION_MAJOR).$(BG_VERSION_MINOR).$(BG_VERSION_PATCH)
BG_TOOLCHAIN_BDEPS = \
	binutils \
	pkg-config-lite \
	gcc \
	glibc \
	gnumach-headers \
	hurd-headers \
	mig

bg-toolchain-download:
	@:

bg-toolchain-source:
	@:

bg-toolchain-build:
	@:

bg-toolchain-install: $(call bg-pkg-install-path,bg-toolchain).stamp

$(call bg-pkg-install-path,bg-toolchain).stamp: $(foreach p,$(BG_TOOLCHAIN_BDEPS),$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_INSTALL_PATH)
	rm -rf $(call bg-pkg-install-path,bg-toolchain)
	mkdir -p $(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET)

	pushd $(call bg-pkg-install-path,bg-toolchain)/$(CONFIG_BG_TOOLCHAIN_TARGET)
	$(foreach p,$(BG_TOOLCHAIN_BDEPS),rsync -av $(call bg-pkg-install-path,$(p))/ .;)
	popd

	touch $@

bg-toolchain: bg-toolchain-install

.PHONY: \
	bg-toolchain \
	bg-toolchain-install \
	bg-toolchain-build \
	bg-toolchain-source \
	bg-toolchain-download
