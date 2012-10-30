#!/sbin/busybox sh

# mDNIe sharpness tweaks by hardcore script'ed

for i in `ls -1 /sys/class/misc/mdnie/t*`;do
echo 3A 9 > $i
echo 3F F > $i
echo 3B 0 > $i
echo 3C 0 > $i
echo 42 0 > $i
echo 4D 0 > $i
done;

