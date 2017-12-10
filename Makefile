# Using the RGBDS toolchain
RGBDS_ASM=rgbasm
RGBDS_LNK=rgblink
RGBDS_FIX=rgbfix

BUILD_DIR=./build

INPUT_DIRS=character_writer
ROMS=$(INPUT_DIRS:%=%.gb)

all: build_dir $(ROMS)

build_dir:
	@mkdir -p $(BUILD_DIR)

$(ROMS):
	$(info Building $@)
	@$(RGBDS_ASM) -i ./ -o $(BUILD_DIR)/$(basename $@).o $(basename $@)/main.asm
	@$(RGBDS_LNK) -o $(BUILD_DIR)/$@ $(BUILD_DIR)/$(basename $@).o
	@$(RGBDS_FIX) -v $(BUILD_DIR)/$@
	$(info Finished $@)

clean:
	rm $(BUILD_DIR)/*.o $(BUILD_DIR)/*.gb
