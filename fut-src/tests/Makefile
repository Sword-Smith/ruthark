default: check test

TESTS_DIR := ./
TESTS_FILES := $(wildcard $(TESTS_DIR)/*.fut)

check: $(TESTS_FILES)
	for file in $^ ; do \
		futhark check $${file} ; \
	done

test: $(TESTS_FILES)
	futhark test $^


opencl:
	futhark test --backend=opencl RescuePrimeTests.fut


cldevices:
	clinfo --human

