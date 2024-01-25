setup:

CARGO := $(shell cargo --version 2>/dev/null)
ifndef CARGO
$(curl https://sh.rustup.rs -sSf | sh -s -- -y)
endif

AFTMAN := $(shell cargo install --list | grep aftman)
ifndef AFTMAN
$(shell cargo install aftman)
$(shell aftman self-install)
endif

$(shell aftman install --no-trust-check)
$(shell wally install)
