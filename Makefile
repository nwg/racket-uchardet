.SUFFIXES:


ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
build_dir := build-uchardet-lib
uchardet_src := $(build_dir)/src
libuchardet := $(uchardet_src)/libuchardet.dylib
lib_src := $(uchardet_src)
lib_dest := src/uchardet/lib
all_libs := libuchardet.0.0.7.dylib libuchardet.0.dylib libuchardet.dylib
all_libs_dst := $(patsubst %.dylib,$(lib_dest)/%.dylib,$(all_libs))
all_libs_src := $(patsubst %.dylib,$(build_dir)/src/%.dylib,$(all_libs))

.PHONY: all
all: $(all_libs_src) $(all_libs_dst)

.PHONY: clean
clean:
	rm -rf $(lib_dest)
	rm -rf $(build_dir)

$(libuchardet): $(build_dir)
	cd $(build_dir) && cmake $(uchardet_src) && gmake

$(lib_dest) $(build_dir):
	mkdir -p $@

$(info $(lib_dest))
$(info $(lib_src))

$(lib_dest)/%.dylib: $(lib_src)/%.dylib
	cp -a $< $@
