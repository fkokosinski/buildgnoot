# Buildgnoot - GNU Hurd headers package
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

HURD_HEADERS_VERSION = 2336993cf542f430a424fbad426844594c80d213
HURD_HEADERS_URI = git://git.git.savannah.gnu.org/hurd/hurd.git
HURD_HEADERS_BDEPS = mig

HURD_HEADERS_AUTOTOOLS_RUN_AUTORECONF = yes
HURD_HEADERS_AUTOTOOLS_CONFIGURE_FLAGS = \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--disable-profile \
	--without-libbz2 \
	--without-libz \
	--without-rump \
	--disable-ncursesw \
	--without-parted

HURD_HEADERS_AUTOTOOLS_INSTALL_TARGETS = no_deps=t install-headers

$(eval $(call bg-fetch-git,hurd-headers))
$(eval $(call bg-build-autotools,hurd-headers))
