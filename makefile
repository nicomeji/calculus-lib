## sudo apt-get install cxxtest
TARGET_DIR  = target

CXX         = g++
CXXFLAGS    = -std=c++14
CPPFLAGS    = -Iinc -MMD -MP -Wall

OBJECTS = $(addprefix $(TARGET_DIR)/, $(patsubst %.cc, %.o, $(shell find src -type f -name "*.cc";)))
DIRECTORIES = $(sort $(dir $(OBJECTS)))

TESTS = $(shell find test -type f -name "*.h";)
TEST_DIRECTORIES = $(sort $(dir $(OBJECTS)))

.PHONY: clean compile test test_generate test_compile test_run link print-%
.SUFFIXES: .cc .o .h .d

OBJECTS_WITHOUT_MAIN = $(filter-out $(TARGET_DIR)/src/main.o, $(OBJECTS))

define depend_dir
$1: | $(dir $1)
endef

#########################################################
############ EACH OBJECT DEPENDENCIES ###################
#########################################################
# Pull in dependency info for *existing* .o files
-include $(patsubst %.o, %.d, $(OBJECTS))

#########################################################
############### OPENCV DEPENDENCIES #####################
#########################################################
## sudo apt-get install libopencv-dev python-opencv

# Include directories for OpenCV can be obtain with the following command:
# pkg-config --cflags opencv
CPPFLAGS   += -I/usr/include/opencv

# OpenCV libraries path can be obtain using the following command:
# pkg-config --libs opencv
LOADLIBES   = -L/usr/lib/x86_64-linux-gnu -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d 
LOADLIBES  += -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect 
LOADLIBES  += -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab

#########################################################
###################### LINK #############################
#########################################################

PROG_NM = hello_world

$(TARGET_DIR)/$(PROG_NM): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

#########################################################
###################### TEST #############################
#########################################################

test: | test_generate test_compile test_run

###################################
######## GENERATE TEST ############
###################################

test_generate: $(TARGET_DIR)/test/testRunner.cc

$(TARGET_DIR)/test/testRunner.cc: $(TESTS)
	mkdir -p $(TARGET_DIR)/test/
	cxxtestgen -o $@ --error-printer $^

###################################
######## COMPILE TEST #############
###################################

test_compile: $(TARGET_DIR)/test/testRunner

$(TARGET_DIR)/test/testRunner.o: $(TARGET_DIR)/test/testRunner.cc
	$(COMPILE.cc) -Itest -o $@ $<

$(TARGET_DIR)/test/testRunner: $(TARGET_DIR)/test/testRunner.o $(OBJECTS_WITHOUT_MAIN)
	$(LINK.cc) -Itest $^ $(LOADLIBES) $(LDLIBS) -o $@

###################################
########## RUN TEST ###############
###################################

test_run:
	./$(TARGET_DIR)/test/testRunner

#########################################################
##################### COMPILE ###########################
#########################################################

compile: $(OBJECTS)

$(OBJECTS): $(TARGET_DIR)/%.o: %.cc
	$(COMPILE.cc) -o $@ $<

$(foreach obj,$(OBJECTS), $(eval $(call depend_dir, $(obj))))

$(DIRECTORIES): %:
	mkdir -p $@

#########################################################
###################### CLEAN ############################
#########################################################
clean:
	rm -rf $(TARGET_DIR)

print-%:
	@echo '$*=$($*)'
