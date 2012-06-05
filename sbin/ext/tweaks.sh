#!/sbin/busybox sh
# thanks to hardcore and nexxx
# some parameters are taken from http://forum.xda-developers.com/showthread.php?t=1292743 (highly recommended to read)

#thanks to pikachu01@XDA
/sbin/busybox sh /sbin/ext/thunderbolt.sh
mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /cache /cache;
mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /data /data;

echo 8192 > /proc/sys/vm/min_free_kbytes
echo 0 > /proc/sys/vm/swappiness
echo 90 > /proc/sys/vm/dirty_ratio
echo 40 > /proc/sys/vm/dirty_background_ratio
echo 20 > /proc/sys/vm/vfs_cache_pressure
echo 2000 > /proc/sys/vm/dirty_writeback_centisecs
echo 200 > /proc/sys/vm/dirty_expire_centisecs

echo 10000000 > /proc/sys/kernel/sched_latency_ns 
echo 2000000 > /proc/sys/kernel/sched_wakeup_granularity_ns

# the following tweaks are commented and left here as an example for those who want to enable them
#setprop ro.telephony.call_ring.delay 1000; # let's minimize the time Android waits until it rings on a call
#if [ "`getprop dalvik.vm.heapsize | sed 's/m//g'`" -lt 64 ];then
#	setprop dalvik.vm.heapsize 64m; # leave that setting to cyanogenmod settings or uncomment it if needed
#fi;
#setprop wifi.supplicant_scan_interval 120; # higher is not recommended, scans while not connected anyway so shouldn't affect while connected
#if  [ -z "`getprop windowsmgr.max_events_per_sec`"  ] || [ "`getprop windowsmgr.max_events_per_sec`" -lt 60 ];then
#	setprop windowsmgr.max_events_per_sec 60; # smoother GUI
#fi;

sysctl -w kernel.sem="500 512000 100 2048";
sysctl -w kernel.shmmax=268435456;
sysctl -w kernel.msgmni=1024;

# touch sensitivity settings.
(
# offset 59: MXT224_THRESHOLD_BATT_INIT
kmemhelper -n mxt224_data -t char -o 59 50
# offset 60: MXT224_THRESHOLD_CHRG
kmemhelper -n mxt224_data -t char -o 60 55
# offset 61: MXT224_NOISE_THRESHOLD_BATT
kmemhelper -n mxt224_data -t char -o 61 30
# offset 62: MXT224_NOISE_THRESHOLD_CHRG
kmemhelper -n mxt224_data -t char -o 62 40
# offset 63: MXT224_MOVFILTER_BATT
kmemhelper -n mxt224_data -t char -o 63 11
# offset 64: MXT224_MOVFILTER_CHRG
kmemhelper -n mxt224_data -t char -o 64 46
# offset 67: MXT224E_THRESHOLD_BATT
kmemhelper -n mxt224_data -t char -o 67 50
# offset 77: MXT224E_MOVFILTER_BATT
kmemhelper -n mxt224_data -t char -o 77 46
)&

# my favorite mdnie settings for red and blue
echo "1" > /sys/devices/platform/samsung-pd.2/mdnie/mdnie/mdnie/user_mode
echo "132" > /sys/devices/platform/samsung-pd.2/mdnie/mdnie/mdnie/user_cb
echo "122" > /sys/devices/platform/samsung-pd.2/mdnie/mdnie/mdnie/user_cr
