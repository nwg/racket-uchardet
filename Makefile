.SUFFIXES:

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
build_dir := $(ROOT_DIR)/build/libuchardet
uchardet_src := $(build_dir)/src
libuchardet := $(uchardet_src)/libuchardet.dylib
lib_src := $(uchardet_src)
lib_dest := $(ROOT_DIR)/uchardet/lib
all_libs := libuchardet.0.0.7.dylib libuchardet.0.dylib libuchardet.dylib
all_libs_dst := $(patsubst %.dylib,$(lib_dest)/%.dylib,$(all_libs))
all_libs_src := $(patsubst %.dylib,$(build_dir)/src/%.dylib,$(all_libs))
uchardet_checkout := $(ROOT_DIR)/third-party/uchardet

.PHONY: all
all: $(all_libs_src) $(all_libs_dst)

.PHONY: clean
clean:
	rm -rf $(lib_dest)
	rm -rf $(build_dir)

$(all_libs_src): $(build_dir)
	cd $(build_dir) && cmake $(uchardet_checkout) && gmake

$(lib_dest) $(build_dir):
	mkdir -p $@

$(all_libs_dst): $(lib_dest)

$(lib_dest)/%.dylib: $(lib_src)/%.dylib
	cp -a $< $@
	touch $@
