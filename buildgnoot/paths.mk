# Buildgnoot - path transforming targets and helpers
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

# bg-abspath - strips quotes and converts to absolute path
# 
# Inputs:
#  - $(1): relative path
# 
# output: absolute path with quotes stripped
define bg-abspath
$(abspath $(patsubst "%",%,$(1)))
endef

# bg-suffix - returns a URI extension suffix
# 
# Inputs:
#  - $(1): URI
# 
# output: suffix
define bg-suffix
$(shell scripts/get-suffix.sh $(1))
endef

BG_DOWNLOAD_PATH = $(call bg-abspath,$(or $(CONFIG_BG_DOWNLOAD_PATH),.download))
BG_PATHS += $(BG_DOWNLOAD_PATH)

BG_SOURCE_PATH = $(call bg-abspath,$(or $(CONFIG_BG_SOURCE_PATH),.source))
BG_PATHS += $(BG_SOURCE_PATH)

BG_BUILD_PATH = $(call bg-abspath,$(or $(CONFIG_BG_BUILD_PATH),.build))
BG_PATHS += $(BG_BUILD_PATH)

BG_INSTALL_PATH = $(call bg-abspath,$(or $(CONFIG_BG_INSTALL_PATH),.install))
BG_PATHS += $(BG_INSTALL_PATH)

$(BG_PATHS):
	@mkdir -p $@
