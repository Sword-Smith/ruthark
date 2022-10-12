SRC_DIR := ./
SRC_FILES := $(wildcard $(SRC_DIR)/*.fut)

futhark: $(SRC_FILES)
	for file in $^ ; do \
		futhark check $${file} ; \
	done

test_verbose: $(SRC_FILES)
	for file in $^ ; do \
		echo ">>> $${file} <<<" ;\
		futhark test $${file} ; \
	done

test: $(SRC_FILES)
	futhark test $^

.PHONY: clean
clean:
	git clean -xi
