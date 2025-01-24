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
	cp $(BUILD_DIR)/third_party/SDL/libSDL3.so.0.2.1 $(BIN_DIR)/libSDL3.so.0
	cp $(BUILD_DIR)/third_party/SDL_image/libSDL3_image.so.0.1.1 $(BIN_DIR)/libSDL3_image.so.0
	echo "LD_PRELOAD=./libSDL3.so.0:./libSDL3_image.so.0 ./$(BIN)" >> $(BIN_DIR)/start.sh
	chmod +x $(BIN_DIR)/start.sh

clean:
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(BIN_DIR)
