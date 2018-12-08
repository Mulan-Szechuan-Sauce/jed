# Compiler
CC   = g++
INCLUDES = -I lib/json/single_include/nlohmann/
OPTS = -std=gnu++11 -g $(INCLUDES)

SRC_DIR = 'src'
OBJ_DIR = 'obj'

main: compile

setup:
	git submodule init
	git submodule update
	mkdir -p $(OBJ_DIR)

compile:
	flex -o $(OBJ_DIR)/jed.yy.c $(SRC_DIR)/jed.l
	bison -d -o $(OBJ_DIR)/jed.tab.c $(SRC_DIR)/jed.y
	$(CC) $(OPTS) $(OBJ_DIR)/jed.tab.c $(SRC_DIR)/jed.cpp -o jed
