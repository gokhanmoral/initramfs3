#!/sbin/busybox sh
# Logging
#/sbin/busybox cp /data/user.log /data/user.log.bak
#/sbin/busybox rm /data/user.log
#exec >>/data/user.log
#exec 2>&1

mkdir /data/.siyah
chmod 777 /data/.siyah
ccxmlsum=`md5sum /res/customconfig/customconfig.xml | awk '{print $1}'`
if [ "a${ccxmlsum}" != "a`cat /data/.siyah/.ccxmlsum`" ];
then
  rm -f /data/.siyah/*.profile
  echo ${ccxmlsum} > /data/.siyah/.ccxmlsum
fi
[ ! -f /data/.siyah/default.profile ] && cp /res/customconfig/default.profile /data/.siyah
[ ! -f /data/.siyah/battery.profile ] && cp /res/customconfig/battery.profile /data/.siyah/battery.profile
[ ! -f /data/.siyah/performance.profile ] && cp /res/customconfig/performance.profile /data/.siyah/performance.profile

. /res/customconfig/customconfig-helper
read_defaults
read_config

#default cpu gov.
echo pegasusq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

#cpu undervolting
echo "${cpu_undervolting}" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels

#mdnie sharpness tweak
if [ "$mdniemod" == "on" ];then
. /sbin/ext/mdnie-sharpness-tweak.sh
fi

#change cpu step count
case "${cpustepcount}" in
  5)
    echo 1200 1000 800 500 200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
  6)
    echo 1400 1200 1000 800 500 200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
  7)
    echo 1500 1400 1200 1000 800 500 200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
  8)
    echo 1600 1400 1200 1000 800 500 200 100 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
  9)
    echo 1600 1500 1400 1200 1000 800 500 200 100 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
  16)
    echo 1600 1500 1400 1300 1200 1100 1000 900 800 700 600 500 400 300 200 100 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
    ;;
esac;

if [ "$logger" == "on" ];then
insmod /lib/modules/logger.ko
fi

# disable debugging on some modules
if [ "$logger" == "off" ];then
  rm -rf /dev/log
  echo 0 > /sys/module/ump/parameters/ump_debug_level
  echo 0 > /sys/module/mali/parameters/mali_debug_level
  echo 0 > /sys/module/kernel/parameters/initcall_debug
  echo 0 > /sys//module/lowmemorykiller/parameters/debug_level
  echo 0 > /sys/module/earlysuspend/parameters/debug_mask
  echo 0 > /sys/module/alarm/parameters/debug_mask
  echo 0 > /sys/module/alarm_dev/parameters/debug_mask
  echo 0 > /sys/module/binder/parameters/debug_mask
  echo 0 > /sys/module/xt_qtaguid/parameters/debug_mask
fi

# for ntfs automounting
insmod /lib/modules/fuse.ko
mount -o remount,rw /
mkdir -p /mnt/ntfs
chmod 777 /mnt/ntfs
mount -o mode=0777,gid=1000 -t tmpfs tmpfs /mnt/ntfs
mount -o remount,ro /

/sbin/busybox sh /sbin/ext/properties.sh

/sbin/busybox sh /sbin/ext/install.sh

##### Early-init phase tweaks #####
/sbin/busybox sh /sbin/ext/tweaks.sh

/sbin/busybox mount -t rootfs -o remount,ro rootfs

##### EFS Backup #####
(
# make sure that sdcard is mounted
sleep 30
/sbin/busybox sh /sbin/ext/efs-backup.sh
) &

sleep 12
#apply last soundgasm level on boot
/res/uci.sh soundgasm_hp $soundgasm_hp

# apply ExTweaks defaults
/res/uci.sh apply

#usb mode
/res/customconfig/actions/usb-mode ${usb_mode}

##### init scripts #####
/sbin/busybox sh /sbin/ext/run-init-scripts.sh
