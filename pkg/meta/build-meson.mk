# Buildgnoot - meson building machinery
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

# bg-pkg-meson-setup-flags - returns meson setup flags
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package setup flags
define bg-pkg-meson-setup-flags
$(call bg-pkg-getprop,$(1),MESON_SETUP_FLAGS)
endef

# bg-build-meson - meson builder; needs to be called with $(eval ...)
#
# Inputs:
#  - $(1): package name
#
# Output: 
define bg-build-meson

$(1)-build: $(bg-pkg-build-path).stamp

$(bg-pkg-build-path).stamp: $(bg-pkg-source-path).stamp $(foreach p,$(bg-pkg-bdeps),$$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_BUILD_PATH) $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-build-path)
	mkdir -p $(bg-pkg-build-path)

	pushd $(bg-pkg-build-path)
	# note: use bg-pkg-install-path-deferred to not depend on alphabetical order of
	# build dependencies
	$(foreach p,$(bg-pkg-bdeps),rsync -av $$(call bg-pkg-install-path,$(p))/ .;)
	export PATH="$$$$PATH:$$$$(realpath ./bin)"
	export PKG_CONFIG_PATH="$$$$(realpath ./lib/pkgconfig)"
	export LDFLAGS="-Wl,-rpath-link,$$$$(realpath ./lib)"

	meson setup ./build $(bg-pkg-source-path) $(bg-pkg-meson-setup-flags)
	meson compile -C ./build

	touch $$@

$(1)-install: $(bg-pkg-install-path).stamp

$(bg-pkg-install-path).stamp: $(bg-pkg-build-path).stamp | $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-install-path)
	mkdir -p $(bg-pkg-install-path)

	pushd $(bg-pkg-build-path)
	export PATH="$$$$PATH:$$$$(realpath ./bin)"
	meson install -C ./build
	popd

	touch $$@

$(1): $(1)-install

.PHONY: $(1)-build $(1)-install $(1)

endef
