default: all

help:
	cat Makefile

all:
	@$(MAKE) fu --no-print-directory
	@$(MAKE) fc --no-print-directory
	@$(MAKE) gl --no-print-directory
	@$(MAKE) rl --no-print-directory

fast: # updating the futhark dependencies is slow almost never needed
	@$(MAKE) gl --no-print-directory
	@$(MAKE) rl --no-print-directory

print_stage:
	@echo ""
	##
	## $(PARAM)
	##
	@echo ""

GENERATOR := rust-generator
GENERATED := gpu-accelerator
FUTHARK_DIR := fut-src

fu: #futhark-upgrade
	@cd $(FUTHARK_DIR) ; futhark pkg upgrade ; futhark pkg sync

fc: #futhark-check
	@PARAM="FUTHARK CHECK" $(MAKE) print_stage --no-print-directory
	@$(MAKE) -C $(FUTHARK_DIR) --no-print-directory

gl: #generate library
	@PARAM="COMPILING LIBRARY GENERATOR" $(MAKE) print_stage
	RUSTFLAGS=-Awarnings cargo build -p $(GENERATOR)
	cargo run -p $(GENERATOR)

rl: #rust library
	@PARAM="COMPILING LIBRARY" $(MAKE) print_stage
	RUSTFLAGS=-Awarnings cargo build -p $(GENERATED)

FUTHARK_RELEASE := 0.22.2
NAME := futhark-$(FUTHARK_RELEASE)-linux-x86_64
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
