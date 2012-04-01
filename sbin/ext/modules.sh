#!/sbin/busybox sh

mkdir /data/.siyah
chmod 777 /data/.siyah
[ ! -f /data/.siyah/default.profile ] && cp /res/customconfig/default.profile /data/.siyah
[ ! -f /data/.siyah/battery.profile ] && cp /res/customconfig/battery.profile /data/.siyah
[ ! -f /data/.siyah/performance.profile ] && cp /res/customconfig/performance.profile /data/.siyah


. /res/customconfig/customconfig-helper
read_defaults
read_config

/sbin/busybox mount rootfs / -o remount,rw

#### proper module support ####
#siyahver=`uname -r`
#mkdir /lib/modules/$siyahver
#for i in `ls -1 /lib/modules/*.ko`;do
#  basei=`basename $i`
#  ln /lib/modules/$basei /lib/modules/$siyahver/$basei
#done;
#depmod /lib/modules/$siyahver

/sbin/busybox mount rootfs / -o remount,ro

#android logger
if [ "$logger" == "on" ];then
insmod /lib/modules/logger.ko
fi
#fm radio, I have no idea why it isn't loaded in init -gm
insmod /lib/modules/Si4709_driver.ko
# for ntfs automounting
insmod /lib/modules/fuse.ko
# for HID
insmod /lib/modules/g_hid.ko

