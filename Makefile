# nvidia-smi - shows you the processes using nvidia gpu memory

help:
	cat Makefile

all:
	@$(MAKE) fc --no-print-directory
	@$(MAKE) generated --no-print-directory
	# @$(MAKE) tf --no-print-directory

print_stage:
	@echo ""
	##
	## $(PARAM)
	##
	@echo ""

SRC_DIR := futhark_source
fc:	
	@PARAM="FUTHARK CHECK" $(MAKE) print_stage --no-print-directory
	@cd futhark-library && $(MAKE) -C $(SRC_DIR) --no-print-directory
	
updatefut:
	@cd futhark-library/$(SRC_DIR) ; futhark pkg upgrade ; futhark pkg sync

exports:
	export CPATH=/opt/cuda/include:$CPATH
	export LD_LIBRARY_PATH=/opt/cuda/lib64/:$LD_LIBRARY_PATH
	export LIBRARY_PATH=/opt/cuda/lib64:$LIBRARY_PATH

generated:
	@PARAM="COMPILING LIBRARY GENERATOR" $(MAKE) print_stage 
	cd futhark-library && cargo build && cargo run

	cp -fur ./futhark-library/generated_lib ./

	@PARAM="COMPILING LIBRARY" $(MAKE) print_stage 
	cd generated_lib  && RUSTFLAGS=-Awarnings cargo build
	
	@PARAM="QUIETLY FIX GENERATED CODE" $(MAKE) print_stage 
	cd generated_lib  && cargo fix --allow-dirty --allow-staged --allow-no-vcs 2> /dev/null

tf:
	@PARAM="TWENTY-FIRST" $(MAKE) print_stage 
	cd twenty-first && cargo build && cargo test futhark

clean:
	cd futhark-library && cargo clean
	cd generated_lib && cargo clean
	cd twenty-first && cargo clean

update:
	cd futhark-library && cargo update
	cd generated_lib && cargo update
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
