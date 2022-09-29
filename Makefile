help:
	cat Makefile

all:
	@$(MAKE) futhark --no-print-directory
	@$(MAKE) generator --no-print-directory
	@$(MAKE) generated --no-print-directory
	@$(MAKE) user --no-print-directory
	@$(MAKE) twenty-first-fut --no-print-directory

futhark:
	futhark check futhark_source/matmul.fut

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

twenty-first-fut:
	cargo build -p twenty-first-fut
	cargo run --bin twenty-first-fut

clean:
	cargo clean
