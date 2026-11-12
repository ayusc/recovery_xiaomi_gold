#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 The TWRP Open Source Project
# Copyright (C) 2025 PitchBlack Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common PBRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from gold device
$(call inherit-product, device/xiaomi/gold/device.mk)

# Device identifier
PRODUCT_DEVICE := gold
PRODUCT_NAME := pb_gold
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 2312DRAABG
PRODUCT_MANUFACTURER := Xiaomi
