# Buildgnoot

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
