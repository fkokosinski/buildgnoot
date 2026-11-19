# Buildgnoot - image meta package
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

BG_IMAGE_VERSION = $(BG_VERSION_MAJOR).$(BG_VERSION_MINOR).$(BG_VERSION_PATCH)
BG_IMAGE_BDEPS = bg-rootfs

bg-image-download:
	@:

bg-image-source:
	@:

bg-image-build:
	@:

bg-image-install: $(call bg-pkg-install-path,bg-image).img

$(call bg-pkg-install-path,bg-image).img: $(foreach p,$(BG_IMAGE_BDEPS),$(call bg-pkg-deferred-install-path,$(p)).stamp) | $(BG_INSTALL_PATH)
	./pkg/bg-image/image.sh $@ $(call bg-pkg-install-path,bg-rootfs)

bg-image: bg-image-install

.PHONY: \
	bg-image \
	bg-image-install \
	bg-image-build \
	bg-image-source \
	bg-image-download
