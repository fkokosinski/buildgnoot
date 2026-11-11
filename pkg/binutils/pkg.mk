# Buildgnoot - binutils package
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

BINUTILS_VERSION = 2.47
BINUTILS_URI = https://ftpmirror.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.xz
BINUTILS_SHA256 = 154ab23b60070e8f27013c22977f1129425d67d1e8acd6e13010e617811e4cff

$(eval $(call bg-fetch-tarball,binutils))
