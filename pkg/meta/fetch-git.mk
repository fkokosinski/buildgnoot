# Buildgnoot - git fetching machinery
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

# bg-git-download-path - returns a path to a git repository
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package tarball download path
define bg-git-download-path
$(BG_DOWNLOAD_PATH)/$(1)-$(bg-pkg-version)
endef

# bg-fetch-git - git fetcher; needs to be called with $(eval ...)
#
# Inputs:
#  - $(1): package name
#
# Output: 
define bg-fetch-git

$(1)-download: $(bg-git-download-path).stamp

$(bg-git-download-path).stamp: | $(BG_DOWNLOAD_PATH)
	rm -rf $(bg-git-download-path)
	git clone $(bg-pkg-uri) $(bg-git-download-path)

	pushd $(bg-git-download-path)
	git checkout $(bg-pkg-version)
	popd

	touch $$@

$(1)-source: $(bg-pkg-source-path).stamp

$(bg-pkg-source-path).stamp: $(bg-git-download-path).stamp | $(BG_SOURCE_PATH)
	rm -rf $(bg-pkg-source-path)
	cp -r $(bg-git-download-path) $(bg-pkg-source-path)
	touch $$@

.PHONY: $(1)-download

endef
