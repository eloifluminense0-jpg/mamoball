TARGET := iphone:clang:latest:14.0
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FlorkMacro

FlorkMacro_FILES = Tweak.x
FlorkMacro_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
FlorkMacro_LIBRARIES = substrate

include $(THEOS)/makefiles/tweak.mk
