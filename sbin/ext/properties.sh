#!/sbin/busybox sh
/sbin/busybox mount -t rootfs -o remount,rw rootfs 
mkdir -p /customkernel/property 
echo true >> /customkernel/property/customkernel.cf-root 
echo true >> /customkernel/property/customkernel.base.cf-root 
echo SiyahKernel >> /customkernel/property/customkernel.name 
echo "SiyahKernel" >> /customkernel/property/customkernel.namedisplay 
echo 104 >> /customkernel/property/customkernel.version.number 
echo 5.2 >> /customkernel/property/customkernel.version.name 
echo true >> /customkernel/property/customkernel.bootani.zip 
echo true >> /customkernel/property/customkernel.bootani.bin 
echo true >> /customkernel/property/customkernel.cwm 
echo 5.0.2.7 >> /customkernel/property/customkernel.cwm.version 
/sbin/busybox mount -t rootfs -o remount,ro rootfs 
