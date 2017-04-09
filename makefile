## sudo apt-get install cxxtest
## sudo apt-get install libopencv-dev python-opencv
TARGET_DIR  = target
PROG_NM     = hello_world

CXX         = g++
CXXFLAGS    = -std=c++11

# Include directories for OpenCV can be obtain with the following command:
# pkg-config --cflags opencv
CPPFLAGS    = -Iinc -I/usr/include/opencv -MMD -MP

# OpenCV libraries path can be obtain using the following command:
# pkg-config --libs opencv
LOADLIBES   = -L/usr/lib/x86_64-linux-gnu -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d 
LOADLIBES  += -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect 
LOADLIBES  += -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab

OBJECTS = $(addprefix $(TARGET_DIR)/, $(patsubst %.cc, %.o, $(shell find src -name "*.cc";)))
DIRECTORIES = $(sort $(dir $(OBJECTS)))

.PHONY: clean print-%
.SUFFIXES: .cc .o .h .d

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

# Pull in dependency info for *existing* .o files
-include $(patsubst %.o, %.d, $(OBJECTS))

define depend_dir
$1: | $(dir $1)
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
