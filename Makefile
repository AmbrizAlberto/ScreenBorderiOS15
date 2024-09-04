INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ScreenBorder

ScreenBorder_FILES = Tweak.x
ScreenBorder_CFLAGS = -fobjc-arc

ARCHS = arm64
TARGET = iphone:clang:latest:15.0

include $(THEOS_MAKE_PATH)/tweak.mk

# Ruta de instalación para rootless
ScreenBorder_INSTALL_PATH = /var/mobile/Library/Tweaks/ScreenBorder
