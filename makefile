SRC_DIR      = src
HEADERS_DIR  = inc
TARGET_DIR   = target
PROG_NM      = hello_wolrd

EXTENTION      = .cc
CXX            = g++
CPPFLAGS       = -std=c++11
COMPILE.cc    += -I $(HEADERS_DIR)

SOURCES      = $(shell find "$(SRC_DIR)" -name "*$(EXTENTION)";)
OBJECTS      = $(call generate_filename, $(SOURCES))
DEPENDENCIES = $(call dependency_name, $(OBJECTS))

define generate_filename
    $(addprefix $(TARGET_DIR)/, $(patsubst %$(EXTENTION), %.o, $(1)))
endef

define dependency_name
	$(patsubst %.o, %.d, $(1))
endef

.PHONY: all clean print-%
.SUFFIXES: $(EXTENTION) .o .h .d

all: $(TARGET_DIR)/$(PROG_NM)
	@echo "$(PROG_NM) created."

# pull in dependency info for *existing* .o files
-include $(DEPENDENCIES)

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(OBJECTS): $(TARGET_DIR)/%.o: %$(EXTENTION)
	mkdir -p $(dir $@)
	$(COMPILE.cc) -o $@ $<
	$(COMPILE.cc) -MM -MT $@ $< > $(call dependency_name, $@)

$(DEPENDENCIES): $(TARGET_DIR)/%.d: %$(EXTENTION)
	mkdir -p $(dir $@)
	$(COMPILE.cc) -MM -MT $@ $< > $(call dependency_name, $@)

clean:
	rm -r $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'
