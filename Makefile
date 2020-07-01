ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
build_dir := build-uchardet-lib
libuchardet := $(build_dir)/src/libuchardet.dylib
uchardet_src := $(ROOT_DIR)/src/third-party/uchardet
package_lib := src/uchardet/lib/libuchardet.dylib

.PHONY: all
all: $(package_lib)

$(build_dir):
	mkdir -p $@

$(libuchardet): $(build_dir)
	cd $(build_dir) && cmake $(uchardet_src) && gmake

$(package_lib):
	mkdir -p $(dir $@)
	cp $(libuchardet) $(package_lib)

