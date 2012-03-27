#!/sbin/busybox sh
if [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

if [ -f /system/bin/customboot.sh ]; then
  /sbin/busybox sh /system/bin/customboot.sh;
fi;

if [ -f /system/xbin/customboot.sh ]; then
  /sbin/busybox sh /system/xbin/customboot.sh
fi;

if [ -f /data/local/customboot.sh ]; then
  /sbin/busybox sh /data/local/customboot.sh
fi;

# fix for samsung roms - setting scaling_max_freq - gm
#if [ "`cat /proc/sys/kernel/rom_feature_set`" == "0" ];
#then
#  freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq`
#  if [ "$freq" != "1200" ];then
#    (
#     sleep 25;
#     echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq;
#    ) &
#  fi
#fi

