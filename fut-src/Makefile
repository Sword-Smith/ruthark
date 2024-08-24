default: check

SRC_DIR := ./
SRC_FILES := $(wildcard $(SRC_DIR)/*.fut)

check: $(SRC_FILES)
	for file in $^ ; do \
		futhark check $${file} ; \
	done

test:
	$(MAKE) -C tests

sync:
	futhark pkg sync

.PHONY: clean
clean:
	git clean -Xi
