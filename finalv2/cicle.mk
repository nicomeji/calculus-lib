.PHONY: all compile test build install

all: install

install: | build

build: $(APP) | test

test: | compile

