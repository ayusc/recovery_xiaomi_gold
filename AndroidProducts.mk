#
# Copyright (C) 2025 The AERA Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/aera_gold.mk \
    $(LOCAL_DIR)/twrp_gold.mk

COMMON_LUNCH_CHOICES := \
    aera_gold-eng \
    aera_gold-userdebug \
    twrp_gold-eng \
    twrp_gold-userdebug
