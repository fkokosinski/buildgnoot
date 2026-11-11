# Buildgnoot - autotools building machinery
# Copyright (C) 2026 Filip Kokosiński

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# bg-pkg-at-configure-flags - returns Autotools configuration flags
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package configuration flags
define bg-pkg-at-configure-flags
$(call bg-pkg-getprop,$(1),AUTOTOOLS_CONFIGURE_FLAGS)
endef

# bg-pkg-at-configure-flags - returns Autotools build targets
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package build targets
define bg-pkg-at-build-targets
$(call bg-pkg-getprop,$(1),AUTOTOOLS_BUILD_TARGETS)
endef

# bg-pkg-at-configure-flags - returns Autotools install targets
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package inst$(MAKEtargets
define bg-pkg-at-install-targets
$(call bg-pkg-getprop,$(1),AUTOTOOLS_INSTALL_TARGETS)
endef

# bg-build-autotools - autotools builder; needs to be called with $(eval ...)
#
# Inputs:
#  - $(1): package name
#
# Output: 
define bg-build-autotools

$(1)-build: $(bg-pkg-build-path).stamp

$(bg-pkg-build-path).stamp: $(bg-pkg-source-path).stamp | $(BG_BUILD_PATH) $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-build-path)
	mkdir -p $(bg-pkg-build-path)

	pushd $(bg-pkg-build-path)
	$(bg-pkg-source-path)/configure $(bg-pkg-at-configure-flags)
	$(MAKE) -j $(shell nproc) $(bg-pkg-at-build-targets)
	popd

	touch $$@

$(1)-install: $(bg-pkg-install-path).stamp

$(bg-pkg-install-path).stamp: $(bg-pkg-build-path).stamp | $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-install-path)
	mkdir -p $(bg-pkg-install-path)

	pushd $(bg-pkg-build-path)
	$(MAKE) -j $(shell nproc) $(bg-pkg-at-install-targets)
	popd

	touch $$@

$(1): $(1)-install

.PHONY: $(1)-build $(1)-install $(1)

endef
