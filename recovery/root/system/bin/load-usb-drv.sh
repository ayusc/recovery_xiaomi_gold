#!/system/bin/sh
set +e

moddir=/lib/modules

# 1. Base / PMIC / Charger dependencies
insmod $moddir/aee_aed.ko 2>/dev/null
insmod $moddir/mt6360-core.ko 2>/dev/null
insmod $moddir/mt6360-regulator.ko 2>/dev/null

# 2. USB PHY & MUSB Core + Platform Controller
insmod $moddir/phy-generic.ko 2>/dev/null
insmod $moddir/phy-mtk-tphy.ko 2>/dev/null
insmod $moddir/musb_hdrc.ko 2>/dev/null
insmod $moddir/musb_main.ko 2>/dev/null

# 3. Type-C / Charger / Power Delivery / Extcon (for cable attach/detach detection)
insmod $moddir/pd_dbg_info.ko 2>/dev/null
insmod $moddir/tcpc_class.ko 2>/dev/null
insmod $moddir/charger_class.ko 2>/dev/null
insmod $moddir/mt6360_pmu_chg.ko 2>/dev/null
insmod $moddir/tcpc_mt6360.ko 2>/dev/null
insmod $moddir/tcpci_late_sync.ko 2>/dev/null
insmod $moddir/extcon-mtk-usb.ko 2>/dev/null
insmod $moddir/mtk_chg_type_det.ko 2>/dev/null

# 4. Notify MUSB driver that kernel init is done
echo 1 > /sys/module/musb_hdrc/parameters/kernel_init_done 2>/dev/null

# 5. Enable device mode OTG switch
echo 1 > /sys/class/power_supply/usb/otg_switch 2>/dev/null

# 6. Wait for UDC to register in sysfs
UDC=""
for i in $(seq 1 40); do
    for u in /sys/class/udc/*; do
        if [ -e "$u" ]; then
            UDC=$(basename "$u")
            break 2
        fi
    done
    sleep 0.1
done

if [ -z "$UDC" ]; then
    UDC="musb-hdrc"
fi

setprop vendor.usb.controller "$UDC"
setprop sys.usb.controller "$UDC"

# 7. Cycle USB config to force gadget bind
setprop sys.usb.config none
sleep 0.5
setprop sys.usb.config adb

# 8. Wait for adbd to prepare FunctionFS
for i in $(seq 1 30); do
    if [ "$(getprop sys.usb.ffs.ready)" = "1" ]; then
        break
    fi
    sleep 0.1
done

# If sys.usb.state is still not adb, kick again
if [ "$(getprop sys.usb.state)" != "adb" ]; then
    setprop sys.usb.config none
    sleep 0.2
    setprop sys.usb.config adb
fi

exit 0
