
# source files and destination
include ./paths.inc

$(info SOURCE_DIR is '$(SOURCE_DIR)')
$(info DESTINATION_DIR is '$(DESTINATION_DIR)')

# $(ifeq $(SOURCE_DIR),,$(error source dir is undefined))
# $(ifeq $(DESTINATION_DIR),, $(error destination dir is undefined))



# misc
OUTPUT_D = ./output
OUT_SUFFIX = -images.yml

# prerequisites generation
DIRS := $(patsubst %/,%, $(shell cd $(SOURCE_DIR); ls -d */))
RESULT_FILES = $(addprefix $(OUTPUT_D)/, $(addsuffix $(OUT_SUFFIX), $(DIRS)))

# ------------------------------------------------------------------------------
# Phony

.phony: debug clean clean-config move-config

all: clean $(RESULT_FILES)

debug:
	@echo "source: $(SOURCE_DIR)"
	@echo "dirs $(DIRS)"
	@echo  "result_f: $(RESULT_FILES)"

clean:
	@-rm -v $(OUTPUT_D)/*

clean-config:
	-rm -vr $(DESTINATION_DIR)/*

copy-config:
	@-mkdir $(DESTINATION_DIR) 2>/dev/null
	cp $(OUTPUT_D)/* $(DESTINATION_DIR)/

# ------------------------------------------------------------------------------
# Targets

# make all output files depend on the output directory
$(OUTPUT_D):
	mkdir $@

$(OUTPUT_D)/%$(OUT_SUFFIX): $(SOURCE_DIR)/%/ | $(OUTPUT_D)
	@echo
	./update-config.sh $(SOURCE_DIR) $* $@
