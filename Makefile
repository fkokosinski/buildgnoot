# Buildgnoot - main entry point
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

BG_VERSION_MAJOR := 0
BG_VERSION_MINOR := 0
BG_VERSION_PATCH := 1

SHELL = bash
.SHELLFLAGS = -euo pipefail -c
.SECONDEXPANSION:
.ONESHELL:
.DELETE_ON_ERROR:

bg-empty :=
bg-space := $(bg-empty) $(bg-empty)

-include .config

# note: keep these in order
include buildgnoot/kconfig.mk
include buildgnoot/paths.mk
include buildgnoot/pkgs.mk

clean:
	@rm -rf .config
	@rm -rf $(BG_PATHS)

.PHONY: clean

include pkg/meta/*.mk
include pkg/*/pkg.mk
