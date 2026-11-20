# Buildgnoot

## Quick-start guide

```bash
make alldefconfig
make bg-toolchain
make bg-image
qemu-system-x86_64 -hda .install/bg-image-*.img -m 2G -nographic -serial mon:stdio -smp 1
```
