help:
	cat Makefile

all:
	@$(MAKE) futhark --no-print-directory
	@$(MAKE) generator --no-print-directory
	@$(MAKE) generated --no-print-directory
	@$(MAKE) user --no-print-directory
	@$(MAKE) twenty-first --no-print-directory

SRC_DIR := futhark_source
SRC_FILES := $(wildcard $(SRC_DIR)/*.fut)

futhark: $(SRC_FILES)
	for file in $^ ; do \
		futhark check $${file} ; \
	done

generator:
	cargo build -p lib_maker
	cargo run --bin lib_maker

generated:
	RUSTFLAGS=-Awarnings cargo build -p generated_lib
	@# Very quietly fix the generated code so we dont have to
	@# restore when we accidentally save and auto-format it,
	@# or have to suffer the eyestrain of poor formatting.
	@cargo fix -p generated_lib --allow-dirty --allow-staged 2> /dev/null

user:
	cargo build -p user_app
	cargo run --bin user_app

twenty-first:
	cargo build -p twenty-first
	cargo run --bin twenty-first

clean:
	cargo clean
