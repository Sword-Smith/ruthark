SRC_DIR := ./
SRC_FILES := $(wildcard $(SRC_DIR)/*.fut)

futhark: $(SRC_FILES)
	for file in $^ ; do \
		futhark check $${file} ; \
	done
