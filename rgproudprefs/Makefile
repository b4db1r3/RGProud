TARGET := iphone:clang:14.5:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RGProudPrefs

RGProudPrefs_FILES = RGPRootListController.m
RGProudPrefs_FRAMEWORKS = UIKit
RGProudPrefs_PRIVATE_FRAMEWORKS = Preferences
RGProudPrefs_INSTALL_PATH = /Library/PreferenceBundles
RGProudPrefs_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/bundle.mk
