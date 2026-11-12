#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 The AERA Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from gold device
$(call inherit-product, device/xiaomi/gold/device.mk)

# Device identifier
PRODUCT_DEVICE := gold
PRODUCT_NAME := twrp_gold
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 2312DRAABG
PRODUCT_MANUFACTURER := Xiaomi
