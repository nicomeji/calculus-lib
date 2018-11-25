.PHONY: clean print-%
.SUFFIXES: .cc .o .h .mk

TRG := target
SRC := $(shell find "src" -type f -name "*.cc";)
OBJ := $(addprefix $(TRG)/,$(SRC:cc=o))
DEP := $(patsubst %.o,%.mk,$(OBJ))
DIR := $(sort $(dir $(DEP)))

$(APP): $(OBJ)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(DIR): %:
	mkdir -p $@

define mkrule
# $1 -> file.cc
# $2 -> TRG/file.cc
$(2:cc=o): $1 | $(2:cc=mk)
	$(COMPILE.c) -o "$$@" "$$<"

$(2:cc=mk): $1 | $(dir $2)
	$(COMPILE.c) -MMD -MP -MF "$$@" "$$<"
endef

define rule
$(call mkrule,$1,$(addprefix $(TRG)/,$1))
endef

$(foreach src,$(SRC),$(eval $(call rule,$(src))))

clean:
	rm -rf $(TRG)

print-%:
	@echo '$*=$($*)'

ifeq (,$(filter clean print-%,$(MAKECMDGOALS)))
include $(DEP)
endif

