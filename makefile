SRC_DIR      = src
HEADERS_DIR  = inc
TARGET_DIR   = target
PROG_NM      = hello_world

EXTENTION      = .cc
CXX            = g++
CPPFLAGS       = -std=c++11
COMPILE.cc    += -I $(HEADERS_DIR)

SOURCES      = $(shell find "$(SRC_DIR)" -name "*$(EXTENTION)";)
OBJECTS      = $(addprefix $(TARGET_DIR)/, $(patsubst %$(EXTENTION), %.o, $(SOURCES)))

define dependency_name
$(patsubst %.o, %.d, $(1))
endef

.PHONY: all clean print-%
.SUFFIXES: $(EXTENTION) .o .h .d

all: $(TARGET_DIR)/$(PROG_NM)
	@echo "$(PROG_NM) created."

# pull in dependency info for *existing* .o files
-include $(call dependency_name, $(OBJECTS))

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(OBJECTS): $(TARGET_DIR)/%.o: %$(EXTENTION)
	mkdir -p $(dir $@)
	$(COMPILE.cc) -o $@ $<
	$(COMPILE.cc) -MM -MT $@ $< > $(call dependency_name, $@)

clean:
	rm -r $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'

