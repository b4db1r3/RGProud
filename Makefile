TARGET := iphone:clang:14.5:14.5
export ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
FINAL_PACKAGE=1
##THEOS_PACKAGE_SCHEME=rootless
PACKAGE_VERSION = 0.1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = backtowhereiwas

backtowhereiwas_FILES = Tweak.x
backtowhereiwas_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += rgproudprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
