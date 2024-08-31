TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ScreenBorder

ScreenBorder_FILES = Tweak.x
ScreenBorder_CFLAGS = -fobjc-arc

# Ruta correcta para rootless
export TARGET_CONFIGURE_PATH = $(THEOS)/configs/rootless.mk

include $(THEOS_MAKE_PATH)/tweak.mk
