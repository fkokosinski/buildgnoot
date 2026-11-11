# Buildgnoot - package helpers
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

# bg-pkg-fmtprop - formats a string to a property identifier
#
# Inputs:
#  - $(1): property name
#
# Output: property identifier (make variable)
define bg-pkg-fmtprop
$(shell echo "$(1)" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
endef

# bg-pkg-getprop - queries a package property
#
# Inputs:
#  - $(1): package name
#  - $(2): property name
# 
# Output: evaluated property
define bg-pkg-getprop
$($(call bg-pkg-fmtprop,$(1)_$(2)))
endef

# bg-pkg-version - queries package version
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package version
define bg-pkg-version
$(call bg-pkg-getprop,$(1),VERSION)
endef

# bg-pkg-uri - queries package URI
#
# Inputs:
#  - $(1): package name; can be omitted if used within an $(eval $(call ...))
#
# Output: package URI
define bg-pkg-uri
$(call bg-pkg-getprop,$(1),URI)
endef
