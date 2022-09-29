help:
	cat Makefile

all:
	@$(MAKE) futhark-check --no-print-directory
	@$(MAKE) generated --no-print-directory
	@$(MAKE) tf --no-print-directory

print_stage:
	@echo ""
	##
	## $(PARAM)
	##
	@echo ""

SRC_DIR := futhark_source
futhark-check:
	@PARAM="FUTHARK CHECK" $(MAKE) print_stage 
	cd futhark-library && $(MAKE) -C $(SRC_DIR) --no-print-directory
	
generated:
	@PARAM="COMPILING LIBRARY GENERATOR" $(MAKE) print_stage 
	cd futhark-library && cargo build && cargo run

	@PARAM="COMPILING LIBRARY" $(MAKE) print_stage 
	cd futhark-library/generated_lib  && RUSTFLAGS=-Awarnings cargo build
	
	@PARAM="QUIETLY FIX GENERATED CODE" $(MAKE) print_stage 
	cd futhark-library/generated_lib  && cargo fix --allow-dirty --allow-staged --allow-no-vcs 2> /dev/null

tf:
	@PARAM="TWENTY-FIRST" $(MAKE) print_stage 
	cd twenty-first && cargo build && cargo test futhark

clean:
	cd futhark-library && cargo clean
	cd futhark-library/generated_lib && cargo clean
	cd twenty-first && cargo clean

update:
	cd futhark-library && cargo update
	cd futhark-library/generated_lib && cargo update
	cd twenty-first && cargo update

RELEASE := 0.22.2
NAME := futhark-$(RELEASE)-linux-x86_64
TAR := $(NAME).tar.xz
get-futhark:
	curl https://futhark-lang.org/releases/$(TAR) --output $(TAR)
	tar -xf $(TAR)
	cd $(NAME) && sudo $(MAKE) install
	rm $(TAR) $(NAME) -rf
	@echo ""
	@echo "========================================"
	@echo "====== 🦔 You now have Futhark 🦔 ======"
	@echo "========================================"
	@echo ""
	@futhark -V
