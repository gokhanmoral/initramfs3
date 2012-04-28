#!/sbin/busybox sh
# thanks to hardcore and nexxx
# some parameters are taken from http://forum.xda-developers.com/showthread.php?t=1292743 (highly recommended to read)

#thanks to pikachu01@XDA
/sbin/busybox sh /sbin/ext/thunderbolt.sh
mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /cache /cache;
mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /data /data;

