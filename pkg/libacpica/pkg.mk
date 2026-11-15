# Buildgnoot - libacpica package
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

LIBACPICA_VERSION = fd286403844463d9652841af47db1afe4b76e8c4
LIBACPICA_URI = https://salsa.debian.org/hurd-team/libacpica.git

LIBACPICA_PATCHES = $(foreach p,$(wildcard pkg/libacpica/patches/*.diff),$(abspath $(p)))
LIBACPICA_BDEPS = libirqhelp libpciaccess

LIBACPICA_MAKE_BUILD_TARGETS = \
	CC=$(CONFIG_BG_TOOLCHAIN_TARGET)-gcc \
	AR=$(CONFIG_BG_TOOLCHAIN_TARGET)-ar \
	PREFIX=$(bg-pkg-install-path) \
	all
	
$(eval $(call bg-fetch-git,libacpica))
$(eval $(call bg-build-make,libacpica))
