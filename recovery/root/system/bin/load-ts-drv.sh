#!/system/bin/sh
set +e

moddir=/lib/modules

# Core dependencies
insmod $moddir/miev.ko
insmod $moddir/xiaomi_touch.ko
insmod $moddir/hqsys_pcba.ko
insmod $moddir/hqsysfs.ko
insmod $moddir/hq_notifier.ko
insmod $moddir/mt6359p-accdet.ko

# Focaltech touchscreen driver
insmod $moddir/focaltech_tp.ko

# Goodix touchscreen drivers
insmod $moddir/gt9916r.ko
insmod $moddir/gt9886.ko
insmod $moddir/gt9896s.ko

exit 0
