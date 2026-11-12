#!/sbin/sh
set +e

moddir=/lib/modules

# Wi-Fi kernel module dependencies
insmod $moddir/rfkill.ko
insmod $moddir/cfg80211.ko
insmod $moddir/btif_drv.ko
insmod $moddir/ccci_util_lib.ko
insmod $moddir/ccci_auxadc.ko
insmod $moddir/rps_perf.ko
insmod $moddir/ccmni.ko
insmod $moddir/conn_md_drv.ko
insmod $moddir/mtk_low_battery_throttling.ko
insmod $moddir/mtk_dynamic_loading_throttling.ko
insmod $moddir/mtk_mdpm_v1.ko
insmod $moddir/mtk_pbm.ko
insmod $moddir/connadp.ko
insmod $moddir/ccci_md_all.ko
insmod $moddir/mddp.ko

# MediaTek WMT Connectivity driver
insmod $moddir/wmt_drv.ko

exit 0
