#
# Copyright (C) 2025 The AERA Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

export LC_ALL="C"
export MAINTAINER=Ayus
export AERA_MAINTAINER=Ayus
export AERA_ENABLE_MOBILE_DATA=1

# Ensure aera_secrets is compiled into recovery for Mobile Data SIM PIN management
if [ -f bootable/recovery/Android.mk ] && ! grep -q "LOCAL_SRC_FILES += aera_secrets/aera_secrets.cpp" bootable/recovery/Android.mk; then
    sed -i '/aera_secrets\/aera_secrets\.cpp/d' bootable/recovery/Android.mk
    sed -i '/ifeq (\$(OF_ENABLE_WLAN),1)/i LOCAL_SRC_FILES += aera_secrets/aera_secrets.cpp\n' bootable/recovery/Android.mk
fi
