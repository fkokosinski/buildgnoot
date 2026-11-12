# Buildgnoot - GNU Mach headers package
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

GNUMACH_HEADERS_VERSION = f349a52f3ac6f97024122f59d843f667206913fa
GNUMACH_HEADERS_URI = https://https.git.savannah.gnu.org/git/hurd/gnumach.git/

GNUMACH_HEADERS_AUTOTOOLS_RUN_AUTORECONF = yes
GNUMACH_HEADERS_AUTOTOOLS_CONFIGURE_FLAGS = \
	--target=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--prefix=$(bg-pkg-install-path) \
	--disable-user32
GNUMACH_HEADERS_AUTOTOOLS_INSTALL_TARGETS = install-data

$(eval $(call bg-fetch-git,gnumach-headers))
$(eval $(call bg-build-autotools,gnumach-headers))
