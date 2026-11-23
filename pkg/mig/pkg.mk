# Buildgnoot - Mach interface generator package
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

MIG_VERSION = cb48044b30fcfe10529ecc1129dd68e93ed73835
MIG_URI = git://git.git.savannah.gnu.org/hurd/mig.git

MIG_BDEPS = host-binutils host-gcc-stage-1 gnumach-headers
MIG_AUTOTOOLS_RUN_AUTORECONF = yes
MIG_AUTOTOOLS_CONFIGURE_FLAGS = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	TARGET_CPPFLAGS="-I$(bg-pkg-build-path)/include"

MIG_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
MIG_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-git,mig))
$(eval $(call bg-build-autotools,mig))
