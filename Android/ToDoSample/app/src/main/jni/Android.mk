LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := todo

LOCAL_C_INCLUDES := $(COMPONENTS_PATH)/include/todo
LOCAL_SRC_FILES := todo_jni.cpp \
					$(COMPONENTS_PATH)/src/todo_manager.cpp

LOCAL_LDLIBS := -llog

ifeq ($(strip $(NDK_DEBUG)),1)
	LOCAL_CFLAGS += -D_DEBUG
endif

include $(BUILD_SHARED_LIBRARY)
