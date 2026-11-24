#!/usr/bin/env bash

# Buildgnoot - image creation script
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

set -euxo pipefail
source .config

image=$1
rootfs=$2
image_size="1G"

create_qemu_image() {
    qemu-img create -f raw "$image" "$image_size"
}

part_qemu_image() {
    offset=2048

    parted -s "$image" mklabel msdos
    parted -s "$image" mkpart primary ext2 "${offset}s" 100%
    parted -s "$image" set 1 boot on
    partprobe "$image"

    # note: this is assuming 512 sector size
    mke2fs -t ext2 -o hurd -m 1 -E "offset=$((offset * 512))" -d "$rootfs" "$image"
}

install_grub() {
    mnt_dir="$(mktemp -d /tmp/buildgnoot.XXXXXX)"
    loop="$(sudo losetup --find --show --partscan $image)"

    # install grub
    sudo mount "${loop}p1" "$mnt_dir"
    sudo grub-install \
        --target=i386-pc \
        --directory="$mnt_dir/lib/grub/i386-pc" \
        --boot-directory="$mnt_dir/boot" \
        "$loop"

    sudo umount "$mnt_dir"
    sudo losetup -d "$loop"
    rmdir "$mnt_dir"
}

create_qemu_image
part_qemu_image
install_grub
