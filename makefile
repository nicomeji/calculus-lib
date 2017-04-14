## sudo apt-get install libopencv-dev python-opencv

PROG_NM     = hello_world
TARGET_DIR  = target

CXX         = g++
CXXFLAGS    = -std=c++14
CPPFLAGS    = -Iinc -MMD -MP -Wall

# Include directories for OpenCV can be obtain with the following command:
# pkg-config --cflags opencv
CPPFLAGS   += -I/usr/include/opencv

# OpenCV libraries path can be obtain using the following command:
# pkg-config --libs opencv
LOADLIBES   = -L/usr/lib/x86_64-linux-gnu -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d 
LOADLIBES  += -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect 
LOADLIBES  += -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab

OBJECTS = $(addprefix $(TARGET_DIR)/, $(patsubst %.cc, %.o, $(shell find src -type f -name "*.cc";)))
DIRECTORIES = $(sort $(dir $(OBJECTS)))

.PHONY: all clean link print-%
.SUFFIXES: .cc .o .h .d

MAIN = src/main.cc

define depend_dir
$1: | $(dir $1)
endef

all: $(TARGET_DIR)/$(PROG_NM)

-include test/makefile $(patsubst %.o, %.d, $(OBJECTS))

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS) | test
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(foreach obj,$(OBJECTS), $(eval $(call depend_dir, $(obj))))

$(OBJECTS): $(TARGET_DIR)/%.o: %.cc
	$(COMPILE.cc) -o $@ $<

$(DIRECTORIES): %:
	mkdir -p $@

clean:
	rm -rf $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'
