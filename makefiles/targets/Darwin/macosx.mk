ifeq ($(_THEOS_TARGET_LOADED),)
_THEOS_TARGET_LOADED := 1
THEOS_TARGET_NAME := macosx

_THEOS_TARGET_PLATFORM_NAME := macosx
_THEOS_TARGET_PLATFORM_SDK_NAME := MacOSX
_THEOS_TARGET_PLATFORM_FLAG_NAME := macosx
_THEOS_TARGET_PLATFORM_SWIFT_NAME := apple-macosx
_THEOS_TARGET_DARWIN_BUNDLE_TYPE := hierarchial

TARGET_CODESIGN ?=
TARGET_CODESIGN_FLAGS ?=

TARGET_INSTALL_REMOTE := $(_THEOS_FALSE)
_THEOS_TARGET_DEFAULT_PACKAGE_FORMAT := pkg

include $(THEOS_MAKE_PATH)/targets/_common/darwin_head.mk

# We have to figure out the target version here, as we need it in the calculation of the deployment version.
_TARGET_VERSION_GE_10_8 := $(call __simplify,_TARGET_VERSION_GE_10_8,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 10.8))
_TARGET_VERSION_GE_10_11 := $(call __simplify,_TARGET_VERSION_GE_10_11,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 10.11))
_TARGET_VERSION_GE_10_14 := $(call __simplify,_TARGET_VERSION_GE_10_14,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 10.14))

ifeq ($(_TARGET_VERSION_GE_10_8),1)
_THEOS_TARGET_DEFAULT_OS_DEPLOYMENT_VERSION := 10.6
else
_THEOS_TARGET_DEFAULT_OS_DEPLOYMENT_VERSION := 10.5
endif

_THEOS_DARWIN_STABLE_SWIFT_VERSION := 10.14.4

ifeq ($(_TARGET_VERSION_GE_10_14),1)
ARCHS ?= x86_64
NEUTRAL_ARCH := x86_64
else
ARCHS ?= i386 x86_64
NEUTRAL_ARCH := i386
endif

ifeq ($(_TARGET_VERSION_GE_10_11),1)
_THEOS_DARWIN_CAN_USE_MODULES := $(_THEOS_TRUE)
endif

include $(THEOS_MAKE_PATH)/targets/_common/darwin_tail.mk
endif
