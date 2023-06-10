
SOURCE_DIR = /home/luctins/Nextcloud/By-Type/Pictures/Stickers/library
CONF_D = ~/.config/espanso/match/
OUTPUT_D = ./output

DIRS := $(shell cd $(SOURCE_DIR); ls -d *)


OUT_SUFFIX = -images.autogen.yml

RESULT_FILES = $(addprefix $(OUTPUT_D)/, $(addsuffix $(OUT_SUFFIX), $(DIRS)))

# ------------------------------------------------------------------------------
# Phony

.phony: debug clean clean-config move-config

debug:
	@echo $(DIRS)
	@echo $(RESULT_FILES)

clean:
	rm $(OUTPUT_D)/*

clean-config:
	mkdir $(CONF_D)/old/
	mv -v $(CONF_D)/*$(OUT_SUFFIX) $(CONF_D)/old/


move-config:
	mv $(OUTPUT_D)/* $(CONF_D)

# ------------------------------------------------------------------------------
# Targets

all: $(RESULT_FILES)

# make all output files depend on the output directory
$(OUTPUT_D):
	mkdir $@

$(OUTPUT_D)/%$(OUT_SUFFIX): | $(SOURCE_DIR)/% $(OUTPUT_D)
	./update-config.sh $(SOURCE_DIR) $* $@
	@echo
