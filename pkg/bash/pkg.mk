# Buildgnoot - bash package
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

BASH_VERSION = 5.3
BASH_URI = $(CONFIG_BG_GNU_MIRROR)/gnu/bash/bash-$(BASH_VERSION).tar.gz
BASH_SHA256 = 0d5cd86965f869a26cf64f4b71be7b96f90a3ba8b3d74e27e8e9d9d5550f31ba
BASH_ENV = $(bg-pkg-at-cross-env)

BASH_AUTOTOOLS_CONFIGURE_FLAGS = \
	CFLAGs="-fcommon" \
	--prefix=$(bg-pkg-install-path) \
	--host=$(CONFIG_BG_TOOLCHAIN_TARGET) \
	--without-bash-malloc \
	ac_cv_func_mmap_fixed_mapped=yes \
	ac_cv_func_strcoll_works=yes \
	ac_cv_func_working_mktime=yes \
	bash_cv_func_sigsetjmp=present \
	bash_cv_getcwd_malloc=yes \
	bash_cv_job_control_missing=present \
	bash_cv_printf_a_format=yes \
	bash_cv_sys_named_pipes=present \
	bash_cv_ulimit_maxfds=yes \
	bash_cv_under_sys_siglist=yes \
	bash_cv_unusable_rtsigs=no \
	gt_cv_int_divbyzero_sigfpe=yes

BASH_AUTOTOOLS_BUILD_TARGETS = $(bg-empty)
BASH_AUTOTOOLS_INSTALL_TARGETS = install

$(eval $(call bg-fetch-tarball,bash))
$(eval $(call bg-build-autotools,bash))
