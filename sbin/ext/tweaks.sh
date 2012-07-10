#!/sbin/busybox sh
# thanks to hardcore and nexxx
# some parameters are taken from http://forum.xda-developers.com/showthread.php?t=1292743 (highly recommended to read)

#thanks to pikachu01@XDA for thunderbolt scripts and remounts
#/sbin/busybox sh /sbin/ext/thunderbolt.sh
# Remount all partitions with noatime
for k in $(busybox mount | grep relatime | cut -d " " -f3);
do
#sync;
busybox mount -o remount,noatime $k;
done;

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
