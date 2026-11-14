BG_TOOLCHAIN_VERSION = $(BG_VERSION_MAJOR).$(BG_VERSION_MINOR).$(BG_VERSION_PATCH)

bg-toolchain-download:
	@:

bg-toolchain-source:
	@:

bg-toolchain-build:
	@:

bg-toolchain-install:
	@:

bg-toolchain: bg-toolchain-install

.PHONY: \
	bg-toolchain \
	bg-toolchain-install \
	bg-toolchain-build \
	bg-toolchain-source \
	bg-toolchain-download
