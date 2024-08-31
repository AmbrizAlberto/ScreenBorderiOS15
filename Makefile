INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ScreenBorder

ScreenBorder_FILES = Tweak.x
ScreenBorder_CFLAGS = -fobjc-arc

ARCHS = arm64
TARGET = iphone:clang:latest:latest

include $(THEOS_MAKE_PATH)/tweak.mk
