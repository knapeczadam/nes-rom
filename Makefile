# Variables
NAME := ROM
OUT_FOLDER := out
FILENAME_BASE := $(OUT_FOLDER)/$(NAME)
INPUT_FILES := $(wildcard *.s65)
OBJS = $(addprefix $(OUT_FOLDER)/, $(subst .s65,.o,$(INPUT_FILES)))

# Tools
CA65 := ca65
CL65 := cl65

# Flags
CA65_FLAGS := -t nes
CL65_FLAGS := -t nes --config game.cfg

# Targets

# Create output directory if not exists
$(OUT_FOLDER):
	mkdir -p $(OUT_FOLDER)

# Assemble .s65 file to object
# $(FILENAME_BASE).o: $(INPUT_FILES) $(OUT_FOLDER)
# 	$(CA65) $(CA65_FLAGS) -l $(FILENAME_BASE).lnk -o $@ $<

$(OUT_FOLDER)/%.o: %.s65 $(OUT_FOLDER)
	$(CA65) -t nes -o $@ $<

# Link the object into a NES file
$(FILENAME_BASE).nes: $(OBJS)
	$(CL65) $(CL65_FLAGS) -m $(FILENAME_BASE).map -o $@ $(OBJS)

# Clean target
clean:
	rm -rf $(OUT_FOLDER)

# Default target
all: $(FILENAME_BASE).nes
