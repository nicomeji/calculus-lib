SRC_DIR      = src
HEADERS_DIR  = inc
TARGET_DIR   = target
PROG_NM      = hello_world

EXTENTION   = .cc
CXX         = g++
CXXFLAGS    = -std=c++11
CPPFLAGS    = -I $(HEADERS_DIR) -MMD -MP

SOURCES      = $(shell find "$(SRC_DIR)" -name "*$(EXTENTION)";)
OBJECTS      = $(addprefix $(TARGET_DIR)/, $(patsubst %$(EXTENTION), %.o, $(SOURCES)))

define dependency_name
$(patsubst %.o, %.d, $(1))
endef

.PHONY: clean print-%
.SUFFIXES: $(EXTENTION) .o .h .d

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

# pull in dependency info for *existing* .o files
-include $(patsubst %.o, %.d, $(OBJECTS))

$(OBJECTS): $(TARGET_DIR)/%.o: %$(EXTENTION)
	mkdir -p $(dir $@)
	$(COMPILE.cc) -o $@ $<

clean:
	rm -r $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'

