CC	:= gcc
CFLAGS	:= --ansi -Wall

MODULES   := Model Control View
SRC_DIR   := $(addprefix src/,$(MODULES))
BUILD_DIR := $(addprefix build/,$(MODULES))

SRC       := $(foreach sdir,$(SRC_DIR),$(wildcard $(sdir)/*.c))
OBJ       := $(patsubst src/%.c,build/%.o,$(SRC))
INCLUDES  := $(addprefix -I,$(SRC_DIR))

VPATH = $(SRC_DIR) src

all: build/StructuredLibraryTest

test:
	@echo "SRC_DIR = " $(SRC_DIR)

build/%.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(INCLUDES) -c

build/lib%.a: %.o
	ar rc $@ $<
	ranlib $@

build/StructuredLibraryTest: build/StructuredLibraryTest.o build/libModel.a build/libControl.a build/libView.a
	$(CC) build/StructuredLibraryTest.o -Lbuild -lModel -lControl -lView -o $@ $(CFLAGS)
