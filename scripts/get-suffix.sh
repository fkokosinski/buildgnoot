#!/usr/bin/env bash

# Buildgnoot - get extension part of a URI
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

if [ "$#" -ne "1" ]; then
    echo "Usage: $0 <URI>"
    exit 1
fi

uri="$1"
filename="$(basename "$uri")"

case $filename in
    *.tar.xz)
        echo "tar.xz"
        ;;
    *.tar.gz)
        echo "tar.gz"
        ;;
    *)
        echo "$0: couldn't determine extension for $filename!"
        exit 1
esac
