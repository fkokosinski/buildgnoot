# Buildgnoot - plain make building machinery
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

define bg-pkg-make-build-targets-raw
$(call bg-pkg-getprop-raw,$(1),MAKE_BUILD_TARGETS)
endef

define bg-pkg-make-build-targets
$(call bg-pkg-getprop,$(1),MAKE_BUILD_TARGETS)
endef

define bg-pkg-make-install-targets
$(call bg-pkg-getprop,$(1),MAKE_INSTALL_TARGETS)
endef

# bg-build-make - plain make builder; needs to be called with $(eval ...)
#
# Inputs:
#  - $(1): package name
#
# Output: 
define bg-build-make

$(1)-build: $(bg-pkg-build-path).stamp

$(bg-pkg-build-path).stamp: $(bg-pkg-source-path).stamp $(foreach p,$(bg-pkg-bdeps),$$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_BUILD_PATH) $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-build-path)
	cp -r $(bg-pkg-source-path) $(bg-pkg-build-path)

	pushd $(bg-pkg-build-path)
	# note: use bg-pkg-install-path-deferred to not depend on alphabetical order of
	# build dependencies
	$(foreach p,$(bg-pkg-bdeps),rsync -av $$(call bg-pkg-install-path,$(p))/ .;)
	export PATH="$$$$PATH:$$$$(realpath ./bin)"
	export PKG_CONFIG_PATH="$$$$(realpath ./lib/pkgconfig)"
	export LDFLAGS="-Wl,-rpath-link,$$$$(realpath ./lib) -L$$$$(realpath ./lib)"
	export LIBRARY_PATH=$$$$(realpath ./lib)

ifdef $(bg-pkg-make-build-targets-raw)
	$(bg-pkg-env) $(MAKE) -j $(shell nproc) $(bg-pkg-make-build-targets)
endif
	popd

	touch $$@

$(1)-install: $(bg-pkg-install-path).stamp

$(bg-pkg-install-path).stamp: $(bg-pkg-build-path).stamp | $(BG_INSTALL_PATH)
	rm -rf $(bg-pkg-install-path)
	mkdir -p $(bg-pkg-install-path)

	pushd $(bg-pkg-build-path)
	export PATH="$$$$PATH:$$$$(realpath ./bin)"
	$(MAKE) -j $(shell nproc) $(bg-pkg-make-install-targets)
	popd

	touch $$@

$(1): $(1)-install

.PHONY: $(1)-build $(1)-install $(1)

endef
