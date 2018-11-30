.PHONY: all clean print-%
.SUFFIXES: .cc .o .h .d

TRG := target
APP := $(TRG)/hello
SRC  = $(shell find "src" -type f -name "*.cc";)
OBJ := $(addprefix $(TRG)/,$(SRC:cc=o))

CPPFLAGS  = -Iinc
CXX       = g++
CXXFLAGS  = -std=c++14

$(APP): $(OBJ)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(TRG)/%.o $(TRG)/%.d: %.cc
	$(shell mkdir -p $(dir $@))
	$(COMPILE.cc) -MMD -MP -o "$(TRG)/$(<:cc=o)" "$<"

clean:
	rm -rf $(TRG)

print-%:
	@echo '$*=$($*)'

ifeq (,$(filter clean print-%,$(MAKECMDGOALS)))
-include $(OBJ:o=d)
endif

