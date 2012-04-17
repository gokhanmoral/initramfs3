#!/sbin/busybox sh
# Logging
#/sbin/busybox cp /data/user.log /data/user.log.bak
#/sbin/busybox rm /data/user.log
#exec >>/data/user.log
#exec 2>&1

. /res/customconfig/customconfig-helper
read_defaults
read_config

mkdir /data/.siyah
chmod 777 /data/.siyah
[ ! -f /data/.siyah/default.profile ] && cp /res/customconfig/default.profile /data/.siyah
[ ! -f /data/.siyah/battery.profile ] && cp /res/customconfig/battery.profile /data/.siyah
[ ! -f /data/.siyah/performance.profile ] && cp /res/customconfig/performance.profile /data/.siyah

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
  echo 0 > /sys/module/wakelock/parameters/debug_mask
  echo 0 > /sys/module/userwakelock/parameters/debug_mask
  echo 0 > /sys/module/earlysuspend/parameters/debug_mask
  echo 0 > /sys/module/alarm/parameters/debug_mask
  echo 0 > /sys/module/alarm_dev/parameters/debug_mask
  echo 0 > /sys/module/binder/parameters/debug_mask
  echo 0 > /sys/module/xt_qtaguid/parameters/debug_mask
fi

# for ntfs automounting
insmod /lib/modules/fuse.ko

#/sbin/busybox sh /sbin/ext/busybox.sh

/sbin/busybox sh /sbin/ext/properties.sh

/sbin/busybox sh /sbin/ext/install.sh

# run this because user may have chosen not to install root at boot but he may need it later and install it using ExTweaks
/sbin/busybox sh /sbin/ext/su-helper.sh

##### Early-init phase tweaks #####
/sbin/busybox sh /sbin/ext/tweaks.sh

/sbin/busybox mount -t rootfs -o remount,ro rootfs

##### EFS Backup #####
(
# make sure that sdcard is mounted
sleep 30
/sbin/busybox sh /sbin/ext/efs-backup.sh
) &

##### init scripts #####
(
#apply default config, delay for 5 secs to make sure that everything is initialized
sleep 5
/res/uci.sh apply
sleep 7
/sbin/busybox sh /sbin/ext/run-init-scripts.sh
)&

#read sync < /data/sync_fifo
#rm /data/sync_fifo
