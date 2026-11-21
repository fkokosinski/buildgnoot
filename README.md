# Buildgnoot

Copyright (C) 2026 Filip Kokosiński

Buildgnoot is a custom GNU/Hurd system generator, with the goal of providing
an easy-to-use way of experimenting with GNU/Hurd.

The name _Buildgnoot_ is a portmanteau of [Buildroot](https://buildroot.org/), a
project Buildgnoot is modeled after, and [GNU](https://www.gnu.org/).

Please note that Buildgnoot is still under active development, and is far from
being stable.

## Quick-start guide

```bash
# nix + direnv
echo 'use flake' > .envrc
direnv allow

# generate .config
make alldefconfig

# build buildgnoot
make bg-toolchain
make bg-image

# run qemu
qemu-system-x86_64 -M q35 -hda .install/bg-image-*.img -m 2G -nographic -serial mon:stdio
```

## Acknowledgments

Buildgnoot draws heavily from [Buildroot](https://buildroot.org/).

Buildgnoot wouldn't be possible without previous work done by Flávio Cruz in the
[cross-hurd](https://github.com/flavioc/cross-hurd) project, and without the
[GNU/Hurd From Scratch](https://hurdfromscratch.dev/) book written and published by Tobias Zindl.
