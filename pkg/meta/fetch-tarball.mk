# Buildgnoot - tarball fetching machinery
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

# bg-tarball-download-path - returns a path to a tarball
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package tarball download path
define bg-tarball-download-path
$(BG_DOWNLOAD_PATH)/$(1)-$(bg-pkg-version).$(call bg-suffix,$(bg-pkg-uri))
endef

# bg-fetch-tarball - tarball fetcher; needs to be called with $(eval ...)
#
# Inputs:
#  - $(1): package name
#
# Output: 
define bg-fetch-tarball

$(1)-download: $(bg-tarball-download-path)

$(bg-tarball-download-path): | $(BG_DOWNLOAD_PATH)
	wget $(bg-pkg-uri) -O $$@
	echo '$(bg-pkg-sha256)  $$@' | sha256sum --check --strict

$(1)-source: $(bg-pkg-source-path).stamp

$(bg-pkg-source-path).stamp: $(bg-tarball-download-path) | $(BG_SOURCE_PATH)
	rm -rf $(bg-pkg-source-path)
	tar mxaf $$< -C $(BG_SOURCE_PATH) --transform='s|^[^/]*|$(1)-$(bg-pkg-version)|'
	touch $$@

.PHONY: $(1)-download $(1)-source

endef
