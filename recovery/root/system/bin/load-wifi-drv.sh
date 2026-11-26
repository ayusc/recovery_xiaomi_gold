#!/system/bin/sh
set +e

moddir=/lib/modules

# 1. Flashlight & LED Drivers (in strict dependency order)
insmod $moddir/mt6360-core.ko 2>/dev/null
insmod $moddir/mt6360-regulator.ko 2>/dev/null
insmod $moddir/pmic_lbat_service.ko 2>/dev/null
insmod $moddir/pmic_lvsys_notify.ko 2>/dev/null
insmod $moddir/mtk_battery_oc_throttling.ko 2>/dev/null
insmod $moddir/mtk_low_battery_throttling.ko 2>/dev/null
insmod $moddir/mtk_dynamic_loading_throttling.ko 2>/dev/null
insmod $moddir/mtk_mdpm_v1.ko 2>/dev/null
insmod $moddir/mtk_pbm.ko 2>/dev/null
insmod $moddir/v4l2-flash-led-class.ko 2>/dev/null
insmod $moddir/flashlight.ko 2>/dev/null
insmod $moddir/leds-mt6360.ko 2>/dev/null

chmod 0666 /sys/class/leds/mt6360_flash_ch1/brightness 2>/dev/null
chmod 0666 /sys/class/leds/mt6360_flash_ch2/brightness 2>/dev/null
chown system system /sys/class/leds/mt6360_flash_ch1/brightness 2>/dev/null
chown system system /sys/class/leds/mt6360_flash_ch2/brightness 2>/dev/null

# 2. Wi-Fi & WMT Connectivity Module Dependencies (in strict dependency order)
insmod $moddir/aee_aed.ko 2>/dev/null
insmod $moddir/emi-mpu.ko 2>/dev/null
insmod $moddir/mtk_disp_notify.ko 2>/dev/null
insmod $moddir/rfkill.ko 2>/dev/null
insmod $moddir/cfg80211.ko 2>/dev/null
insmod $moddir/rps_perf.ko 2>/dev/null
insmod $moddir/ccci_util_lib.ko 2>/dev/null
insmod $moddir/ccci_auxadc.ko 2>/dev/null
insmod $moddir/ccmni.ko 2>/dev/null
insmod $moddir/conn_md_drv.ko 2>/dev/null
insmod $moddir/connadp.ko 2>/dev/null
insmod $moddir/device-apc-common.ko 2>/dev/null
insmod $moddir/device-apc-mt6833.ko 2>/dev/null
insmod $moddir/ccci_md_all.ko 2>/dev/null
insmod $moddir/btif_drv.ko 2>/dev/null
insmod $moddir/mddp.ko 2>/dev/null

# 3. MediaTek WMT Connectivity driver
insmod $moddir/wmt_drv.ko 2>/dev/null

# Allow access to connectivity nodes
chmod 0666 /dev/stpwmt 2>/dev/null
chmod 0666 /dev/wmtdetect 2>/dev/null
chmod 0666 /dev/wmtWifi 2>/dev/null

# Signal init that WMT driver is ready so wmt_loader & wmt_launcher start
setprop vendor.wmt.driver.loaded 1

# 4. Wait for wmt_loader to bring connsys up, then load Wi-Fi driver
for i in $(seq 1 20); do
    if [ "$(getprop vendor.connsys.driver.ready)" = "yes" ]; then
        break
    fi
    sleep 0.5
done

insmod $moddir/wmt_chrdev_wifi.ko 2>/dev/null
insmod $moddir/wlan_drv_gen4m_6833.ko 2>/dev/null
echo 1 > /dev/wmtWifi 2>/dev/null

exit 0
