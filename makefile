TARGET_DIR   = target
PROG_NM      = hello_world

CXX         = g++
CXXFLAGS    = -std=c++11
CPPFLAGS    = -I inc -MMD -MP

OBJECTS = $(addprefix $(TARGET_DIR)/, $(patsubst %.cc, %.o, $(shell find src -name "*.cc";)))
DIRECTORIES = $(sort $(dir $(OBJECTS)))

.PHONY: clean print-%
.SUFFIXES: .cc .o .h .d

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

# pull in dependency info for *existing* .o files
-include $(patsubst %.o, %.d, $(OBJECTS))

define depend_dir
$1: $(dir $1)
endef

$(foreach obj,$(OBJECTS), $(eval $(call depend_dir, $(obj))))

$(OBJECTS): $(TARGET_DIR)/%.o: %.cc
	$(COMPILE.cc) -o $@ $<

$(DIRECTORIES): %:
	mkdir -p $@

clean:
	rm -r $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'
