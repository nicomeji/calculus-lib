#######################################################
###################### TEST ###########################
#######################################################
## sudo apt-get install cxxtest

TESTS = $(shell find test -type f -name "*.h";)
TEST_DIRECTORIES = $(sort $(dir $(TESTS)))

OBJECTS_WITHOUT_MAIN = $(filter-out $(addprefix $(TARGET_DIR)/, $(patsubst %.cc, %.o, $(MAIN))), $(OBJECTS))

.PHONY: test

test: $(TARGET_DIR)/test/testRunner
	./$(TARGET_DIR)/test/testRunner

$(TARGET_DIR)/test/testRunner: $(TARGET_DIR)/test/testRunner.o $(OBJECTS_WITHOUT_MAIN)
	$(LINK.cc) -Itest $^ $(LOADLIBES) $(LDLIBS) -o $@

$(TARGET_DIR)/test/testRunner.o: $(TARGET_DIR)/test/testRunner.cc
	$(COMPILE.cc) -Itest -o $@ $<

$(TARGET_DIR)/test/testRunner.cc: $(TESTS)
	mkdir -p $(TARGET_DIR)/test/
	cxxtestgen -o $@ --error-printer $^