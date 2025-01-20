BUILD_DIR:=./build
BIN_DIR=./bin
BIN=vulkan_guide
COMPILER=ninja

all:
	cmake -S . -B $(BUILD_DIR) -G Ninja
	$(COMPILER) -C $(BUILD_DIR)

run: all
	$(BIN_DIR)/$(BIN)

release: all
	strip $(BIN_DIR)/$(BIN)

clean:
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(BIN_DIR)
