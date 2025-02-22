LIBTORCH=$(PWD)/libtorch

.PHONY: build
build:
	LIBTORCH=$(LIBTORCH) cargo build

.PHONY: run
run:
	LIBTORCH=$(LIBTORCH) DYLD_LIBRARY_PATH=$(LIBTORCH)/lib:$$DYLD_LIBRARY_PATH cargo run .
