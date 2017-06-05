## sudo apt-get install libopencv-dev python-opencv


CPPFLAGS    = -Iinc -MMD -MP -Wall

# Include directories for OpenCV can be obtain with the following command:
# pkg-config --cflags opencv
CPPFLAGS   += -I/usr/include/opencv

# OpenCV libraries path can be obtain using the following command:
# pkg-config --libs opencv
LOADLIBES   = -L/usr/lib/x86_64-linux-gnu -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d 
LOADLIBES  += -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect 
LOADLIBES  += -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab

.PHONY: all link
.SUFFIXES: .d

PROG_NM     = hello_world
MAIN        = src/main.cc
TARGET_DIR  = target
all: $(TARGET_DIR)/$(PROG_NM)

SOURCE_FILES = $(shell find src -type f -name "*.cc";)
include makefilecommons

-include test/makefile $(patsubst %.o, %.d, $(OBJECTS))

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS) | test
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@
