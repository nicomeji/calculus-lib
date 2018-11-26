.PHONY: clean print-%
.SUFFIXES: .cc .o .h .mk

SRC := $(shell find "src" -type f -name "*.cc";)
OBJ := $(addprefix $(TRG)/,$(SRC:cc=o))
DEP := $(OBJ:o=mk)

$(APP): $(OBJ)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(DEP): $(TRG)/%.mk: %.cc
	$(shell mkdir -p $(dir $@))
	$(COMPILE.cc) -MMD -MP -MF "$@" "$<"

$(OBJ): $(TRG)/%.o: %.cc
	$(COMPILE.cc) -o "$@" "$<"

clean:
	rm -rf $(TRG)

print-%:
	@echo '$*=$($*)'

ifeq (,$(filter clean print-%,$(MAKECMDGOALS)))
include $(DEP)
endif

