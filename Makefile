ARCHS = arm64 arm64e
TARGET = iphone:clang:14.5:14.5

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MeuMacro
MeuMacro_FILES = Tweak.x
MeuMacro_CFLAGS = -fobjc-arc -Wno-error -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
