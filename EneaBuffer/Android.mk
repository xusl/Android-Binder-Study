# Ashmem shared buffer example
# Created on: 19 mars 2010  Author: Zingo Andersen # License: Public Domain (steal and use what you like)

LOCAL_PATH:= $(call my-dir)

#
# BufferServer
#

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := eng

LOCAL_SRC_FILES:=        \
 IEneaBuffer.cpp      \
 EneaBufferServer.cpp \
   
LOCAL_SHARED_LIBRARIES:= libcutils libutils libbinder

LOCAL_MODULE:= EneaBufferServer

LOCAL_CFLAGS+=-DLOG_TAG=\"EneaBufferServer\"

LOCAL_PRELINK_MODULE:=false
include $(BUILD_EXECUTABLE)

#
# BufferClient
#

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES:=        \
 IEneaBuffer.cpp      \
 EneaBufferClient.cpp \
   
LOCAL_SHARED_LIBRARIES:= libcutils libutils libbinder

LOCAL_MODULE:= EneaBufferClient

LOCAL_CFLAGS+=-DLOG_TAG=\"EneaBufferClient\"

LOCAL_PRELINK_MODULE:=false
include $(BUILD_EXECUTABLE)
