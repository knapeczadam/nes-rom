# Variables
NAME := ROM
OUT_FOLDER := out
FILENAME_BASE := $(OUT_FOLDER)/$(NAME)
INPUT_FILES := $(wildcard *.s65)
OBJS = $(addprefix $(OUT_FOLDER)/, $(subst .s65,.o,$(INPUT_FILES)))

ifeq ($(OS),Windows_NT)
    RM = rmdir /S /Q
    MKDIR = mkdir
else
    RM = rm -rf
    MKDIR = mkdir -p
endif

# Tools
CA65 := ca65
LD65 := ld65

# Flags
CA65_FLAGS := -t nes
LD65_FLAGS := --config game.cfg

# Targets

# Create output directory if not exists
$(OUT_FOLDER):
	$(MKDIR) $(OUT_FOLDER)

# Assemble .s65 file to object
# $(FILENAME_BASE).o: $(INPUT_FILES) $(OUT_FOLDER)
# 	$(CA65) $(CA65_FLAGS) -l $(FILENAME_BASE).lnk -o $@ $<

$(OUT_FOLDER)/%.o: %.s65 $(OUT_FOLDER)
	$(CA65) -t nes -g -o $@ $<

# Link the object into a NES file
$(FILENAME_BASE).nes: $(OBJS)
	$(LD65) $(LD65_FLAGS) -m $(FILENAME_BASE).map --dbgfile $(FILENAME_BASE).dbg -o $@ $(OBJS)

# Clean target
clean:
	$(RM) $(OUT_FOLDER)

# Default target
all: $(FILENAME_BASE).nes
