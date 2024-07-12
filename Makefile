OUTPUT = game.nes

# directories
SRC_DIR = src      # for .asm files
BUILD_DIR = build  # for .o files
ROM_DIR = rom      # for .nes files

SRC_FILES = $(wildcard $(SRC_DIR)/*.asm
OBJ_FILES = $(wildcard $(SRC_DIR)/*.o


# DEFAULT TARGET DEPENDS ON OUTPUT
all: $(OUTPUT)

clean:
	rm -f $(BUILD_DIR)/*.o
	rm -f $(ROM_DIR)/*.nes

# this will create the output, depends on object flles
$(OUTPUT): $(OBJS)

# assemble
# this creates the object files, depends on the src files
$(OBJS): $(SRC) #zzz
