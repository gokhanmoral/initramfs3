#!/sbin/busybox sh

# mDNIe sharpness tweaks by hardcore script'ed

echo 8 88 > /sys/class/misc/mdnie/tune_dynamic_gallery
echo 8 88 > /sys/class/misc/mdnie/tune_dynamic_ui
echo 8 88 > /sys/class/misc/mdnie/tune_dynamic_video
echo 8 8a > /sys/class/misc/mdnie/tune_dynamic_vtcall
echo 8 aa > /sys/class/misc/mdnie/tune_movie_vtcall
echo 8 88 > /sys/class/misc/mdnie/tune_standard_gallery
echo 8 88 > /sys/class/misc/mdnie/tune_standard_ui
echo 8 88 > /sys/class/misc/mdnie/tune_standard_video
echo 8 8a > /sys/class/misc/mdnie/tune_standard_vtcall
echo 8 a8 > /sys/class/misc/mdnie/tune_natural_gallery
echo 8 a8 > /sys/class/misc/mdnie/tune_natural_ui
echo 8 a8 > /sys/class/misc/mdnie/tune_natural_video
echo 8 aa > /sys/class/misc/mdnie/tune_natural_vtcall
echo 8 8 > /sys/class/misc/mdnie/tune_camera
echo 8 408 > /sys/class/misc/mdnie/tune_camera_outdoor
echo 8 e8 > /sys/class/misc/mdnie/tune_cold
echo 8 4e8 > /sys/class/misc/mdnie/tune_cold_outdoor
echo 8 4a8 > /sys/class/misc/mdnie/tune_outdoor
echo 8 e8 > /sys/class/misc/mdnie/tune_warm
echo 8 4e8 > /sys/class/misc/mdnie/tune_warm_outdoor

for i in `ls -1 /sys/class/misc/mdnie`;do
echo 92 0 > /sys/class/misc/mdnie/$i
echo 93 0 > /sys/class/misc/mdnie/$i
echo 94 0 > /sys/class/misc/mdnie/$i
echo 95 0 > /sys/class/misc/mdnie/$i
echo 96 0 > /sys/class/misc/mdnie/$i
echo 97 0 > /sys/class/misc/mdnie/$i
echo 98 0 > /sys/class/misc/mdnie/$i
echo 99 0 > /sys/class/misc/mdnie/$i
done;

