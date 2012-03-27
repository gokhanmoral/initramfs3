
on media-csc
	mount /sdcard1
	mount /cache
	echo "Copying the media files"
	mkdir -p /sdcard1/Samsung/Music
	cp -y -f -r -v /cache/Samsung /sdcard1/Samsung
	unmount /sdcard1
	mount /sdcard1
	cmp -r /cache/Samsung /sdcard1/Samsung 
	echo "Successfully copied the media files"

on multi-csc
	echo 
	echo "-- Appling Multi-CSC..."
	mount /system
	cp -y -f -r -v /system/csc/comm_apk /system/app/
	cp -y -f -r -v /system/csc/comm_so /system/lib
	cp -y -f -r -v /system/csc/comm_data/wallpaper /system/wallpaper/
	cp -y -f -r -v /system/csc/comm_data/media /system/media/
	cp -y -f -r -v /system/csc/comm_data/etc /system/etc/
	echo "Applied the CSC-code : <salse_code>"
	cp -y -f -r -v /system/csc/<salse_code> /
	unmount /system
	mount /system
	cmp -r /system/csc/<salse_code> /
	echo "Successfully applied multi-CSC."

