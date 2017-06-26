## sudo apt-get install libopencv-dev python-opencv
## sudo apt-get install cxxtest

export MAIN TARGET_DIR SRC_DIR CPPFLAGS LOADLIBES

CPPFLAGS    = -Iinc -MMD -MP -Wall

# Include directories for OpenCV can be obtain with the following command:
# pkg-config --cflags opencv
CPPFLAGS   += -I/usr/include/opencv

# OpenCV libraries path can be obtain using the following command:
# pkg-config --libs opencv
LOADLIBES   = -L/usr/lib/x86_64-linux-gnu -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d 
LOADLIBES  += -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect 
LOADLIBES  += -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab -lpthread

.PHONY: all link test coverage
.SUFFIXES: .d

PROG_NM     = hello_world
MAIN        = src/main.cc
TARGET_DIR  = target
SRC_DIR     = src

all: $(TARGET_DIR)/$(PROG_NM) coverage

include makefilecommons

-include $(patsubst %.o, %.d, $(OBJECTS))

$(eval $(call defineDependency,test))

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

coverage: test-coverage
