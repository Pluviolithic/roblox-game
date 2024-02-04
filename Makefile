PACKAGE_INDEX_DIR=./Packages/_Index

setup: wally

rust:
CARGO := $(shell cargo --version 2>/dev/null)
ifndef CARGO
	curl https://sh.rustup.rs -sSf | sh -s -- -y
endif

aftman: rust
AFTMAN := $(shell cargo install --list | grep aftman)
ifndef AFTMAN
	cargo install aftman
	aftman self-install
endif

wally: aftman
	aftman install --no-trust-check
	wally install
	rojo sourcemap "default.project.json" --output sourcemap.json
	wally-package-types --sourcemap sourcemap.json Packages/
	wally-package-types --sourcemap sourcemap.json ServerPackages/