
# source files and destination
CONF_D = ~/.config/espanso
SOURCE_DIR = $(CONF_D)/images/stickers
MATCH_D = $(CONF_D)/match

OUTPUT_D = ./output

# conventions
OUT_SUFFIX = -images.autogen.yml

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
	mkdir $(MATCH_D)/old/
	mv -v $(MATCH_D)/*$(OUT_SUFFIX) $(CONF_D)/old/

copy-config:
	cp $(OUTPUT_D)/* $(MATCH_D)/

# ------------------------------------------------------------------------------
# Targets

# make all output files depend on the output directory
$(OUTPUT_D):
	mkdir $@

$(OUTPUT_D)/%$(OUT_SUFFIX): $(SOURCE_DIR)/%/ | $(OUTPUT_D)
	@echo
	./update-config.sh $(SOURCE_DIR) $* $@
