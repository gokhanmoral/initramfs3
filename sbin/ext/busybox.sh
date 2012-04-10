#!/sbin/busybox sh
# magic busybox

# mount system and rootfs r/w
mount -o rw,remount /system
mount -t rootfs -o remount,rw rootfs

# make sure we have /system/xbin
/sbin/ext/busybox mkdir -p /system/xbin

# if symlinked busybox in /system/bin or /system/xbin, remove them
LINK=$(/sbin/ext/busybox find /system/bin/busybox -type l)
if /sbin/ext/busybox [ $LINK = "/system/bin/busybox" ]; then
  /sbin/ext/busybox rm -rf /system/bin/busybox;
fi;
LINK=$(find /system/xbin/busybox -type l)
if [ $LINK = "/system/xbin/busybox" ]; then
  rm -rf /system/xbin/busybox;
fi;

# if real busybox in /system/bin, move to /system/xbin
if [ -f /system/bin/busybox ]; then
  rm -rf /system/xbin/busybox
  mv /system/bin/busybox /system/xbin/busybox
fi;

# place wrapper script
#cp /sbin/ext/busybox-wrapper /sbin/busybox

# mount system and rootfs r/o
mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system
