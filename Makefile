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
	cp $(BUILD_DIR)/_deps/sdl3-build/libSDL3.so $(BIN_DIR)
	cp $(BUILD_DIR)/_deps/sdl3-build/libSDL3.so.0 $(BIN_DIR)
	cp $(BUILD_DIR)/_deps/sdl3-build/libSDL3.so.0.2.0 $(BIN_DIR)
	echo "LD_PRELOAD=$(pwd)/libSDL3.so ./$(BIN)" >> $(BIN_DIR)/start.sh
	chmod +x $(BIN_DIR)/start.sh

clean:
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(BIN_DIR)
