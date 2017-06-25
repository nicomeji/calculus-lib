## sudo apt-get install cxxtest

.PHONY: test

OBJECTS_WITHOUT_MAIN = $(filter-out $(addprefix $(TARGET_DIR)/,$(patsubst %.cc,%.o,$(MAIN))),$(OBJECTS))
TESTS                = $(shell find test -type f -name "*.h";)
TEST_DIRECTORIES     = $(sort $(dir $(TESTS)))
PROG_NM              = testRunner
CPPFLAGS            += -Itest
CXXFLAGS             = -g -O0 --coverage

test: $(TARGET_DIR)/$(PROG_NM)
	./$(TARGET_DIR)/$(PROG_NM)

COMPILE_TEST.cc = $(CXX) $(CPPFLAGS) $(TARGET_ARCH) -c

include makefilecommons

$(TARGET_DIR)/$(PROG_NM): $(TARGET_DIR)/test/testRunner.o $(OBJECTS_WITHOUT_MAIN)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -g -O0 --coverage -o $@

$(TARGET_DIR)/test/testRunner.o: $(TARGET_DIR)/test/testRunner.cc
	$(COMPILE_TEST.cc) -o $@ $<

$(TARGET_DIR)/test/testRunner.cc: $(TESTS)
	mkdir -p $(TARGET_DIR)/test/
	cxxtestgen -o $@ --error-printer $^
