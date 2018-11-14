# Compiler
CC   = gcc
OPTS = -g -O2

SRC_DIR = 'src'
OBJ_DIR = 'obj'

main: setup compile

setup:
	mkdir -p $(OBJ_DIR)

compile:
	flex -o $(OBJ_DIR)/jed.yy.c $(SRC_DIR)/jed.l
	bison -d -o $(OBJ_DIR)/jed.tab.c $(SRC_DIR)/jed.y
	$(CC) $(OPTS) $(OBJ_DIR)/jed.tab.c -o jed

