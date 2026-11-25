#!/system/bin/sh
set +e

moddir=/lib/modules

# Flashlight drivers
insmod $moddir/mtk_battery_oc_throttling.ko
insmod $moddir/flashlight.ko
insmod $moddir/v4l2-flash-led-class.ko
insmod $moddir/leds-mt6360.ko
chmod 0666 /sys/class/leds/mt6360_flash_ch1/brightness 2>/dev/null
chown system system /sys/class/leds/mt6360_flash_ch1/brightness 2>/dev/null

# Wi-Fi kernel module dependencies
insmod $moddir/rfkill.ko
insmod $moddir/cfg80211.ko
insmod $moddir/pmic_lbat_service.ko
insmod $moddir/pmic_lvsys_notify.ko
insmod $moddir/mtk_low_battery_throttling.ko
insmod $moddir/mtk_dynamic_loading_throttling.ko
insmod $moddir/mtk_mdpm_v1.ko
insmod $moddir/mtk_pbm.ko
insmod $moddir/rps_perf.ko
insmod $moddir/ccci_util_lib.ko
insmod $moddir/ccci_auxadc.ko
insmod $moddir/ccmni.ko
insmod $moddir/conn_md_drv.ko
insmod $moddir/connadp.ko
insmod $moddir/device-apc-common.ko
insmod $moddir/device-apc-mt6833.ko
insmod $moddir/ccci_md_all.ko
insmod $moddir/btif_drv.ko
insmod $moddir/mddp.ko

# MediaTek WMT Connectivity driver
insmod $moddir/wmt_drv.ko

# Signal that WMT driver is ready for loader/launcher
setprop vendor.wmt.driver.loaded 1

exit 0
