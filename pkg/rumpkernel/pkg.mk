# Buildgnoot - rumpkernel package
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

RUMPKERNEL_VERSION = c58606796e1fda72df7b28cf2a840b87538e4bcd
RUMPKERNEL_URI = https://salsa.debian.org/hurd-team/rumpkernel.git
RUMPKERNEL_PATCHES = \
	$(foreach p,$(addprefix pkg/rumpkernel/patches/,$(shell cat pkg/rumpkernel/patches/series)),$(abspath $(p)))

RUMPKERNEL_BDEPS = \
	libpciaccess \
	libirqhelp

rumpkernel-build: $(call bg-pkg-build-path,rumpkernel).stamp

$(call bg-pkg-build-path,rumpkernel).stamp: $(call bg-pkg-source-path,rumpkernel).stamp $(foreach p,$(BG_TOOLCHAIN_BDEPS),$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_BUILD_PATH)
	rm -rf $(call bg-pkg-build-path,rumpkernel)
	cp -r $(call bg-pkg-source-path,rumpkernel) $(call bg-pkg-build-path,rumpkernel)

	pushd $(call bg-pkg-build-path,rumpkernel)
	$(foreach p,$(RUMPKERNEL_BDEPS),rsync -av $(call bg-pkg-install-path,$(p))/ .;)
	mkdir -p ./obj
	popd

	./pkg/rumpkernel/build-rumpkernel.sh \
		$(call bg-pkg-build-path,rumpkernel) \
		$(call bg-pkg-install-path,bg-toolchain)/x86_64-gnu
	touch $@

rumpkernel-install: $(call bg-pkg-install-path,rumpkernel).stamp

$(call bg-pkg-install-path,rumpkernel).stamp: $(call bg-pkg-build-path,rumpkernel).stamp | $(BG_INSTALL_PATH)
	rm -rf $(call bg-pkg-install-path,rumpkernel)

	mkdir -p $(call bg-pkg-install-path,rumpkernel)/usr/include/rump
	mkdir -p $(call bg-pkg-install-path,rumpkernel)/lib

	find $(call bg-pkg-build-path,rumpkernel) -type f,l \
		-name 'librump*.so*' -not -path '*.map' -path '*librumpkern_z*' \
		-exec install -v -m 0644 {} $(call bg-pkg-install-path,rumpkernel)/lib \;

	find $(call bg-pkg-build-path,rumpkernel) -type f,l \
		-name 'librump*.a' -not -path '*librumpkern_z*' \
		-exec install -v -m 0644 {} $(call bg-pkg-install-path,rumpkernel)/lib \;

	find $(call bg-pkg-build-path,rumpkernel)/buildrump.sh/src/sys/rump/include/rump \
		-iname '*.h' \
		-exec install -v -m 0644 {} $(call bg-pkg-install-path,rumpkernel)/usr/include/rump \;

	touch $@

rumpkernel: rumpkernel-install

.PHONY: rumpkernel rumpkernel-install rumpkernel-build

$(eval $(call bg-fetch-git,rumpkernel))
